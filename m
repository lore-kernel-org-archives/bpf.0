Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A085360EC7
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069236; cv=none; b=agVJckSkuzXDItBT0f3vXtqNQhnTPNkoEMhX+T5VI0Jr+sHiJJcl2+HZG3zgXQe6yjf5Wz9ZtUrn4vCfrWTSEAgC9hydSxp4Sid09iYnncm2dMb3KGl6mYwW0lb+QJhzPnjMyLlkO6BAtgWgJQSjAg93UpQAo87ukk4hxaJpCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069236; c=relaxed/simple;
	bh=X2mIPTuVUVzG3Sy48nX/GeVEJ+zkaU2gIP0hEAX9jYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WhHxE9hDXPIle7W0/CHspfBm6raGFOQU6rrWxZdkN4XUXt/iQG7bIRfpwIYIPoCs58T0NHMbG56AGyJbtKbOddRQCFd76w61uCqfsUyhFLgMHy4uqduFBjcwP+i55yaOhtOsf8nHefPmiYqiZUTYesm//ncp3LHGeWfOOjSYYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLn1JD2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLn1JD2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC611F000E9;
	Fri,  3 Jul 2026 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783069234;
	bh=bRlr6RTE1wU4o/W900DOQrm2i1YySRfOk5Ad5VrUcsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLn1JD2luaUBMckiJbl266HElL5cralo5eIx8Nzra+V8moVbitrxHvrVqovU/Z0JY
	 UOy+e+voCo7xBaSxzzsnKAaK1rohPGvffYe/f/UUfDXzW7eXJk6NlXj1QuncnI0+A+
	 1cAATdPOfZn0Vs6GVGJMeJH7GGMSIIkQRaD0WhTPZ1ET83uiHs1n96SqrRlw/SC6Xw
	 noqUmi8QAfTIi9FQ+VufPgvlNdbpPzVbyQbJ/ky7gLR4+hukOVzmuED3OX8AV1GZg+
	 A7ifnnGwEKJiwJzaaI9KwRA9ty+H0XmshxqEAoYDeXbARQvJMl1UopJNTHnC2L2ef5
	 eqIYR3hb//lWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] x86/sgx: Report RCU-Tasks quiescent state in EPC
 sanitization loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Miao" <jun.miao@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260703084810.145567-1-jun.miao@intel.com>
References: <20260703084810.145567-1-jun.miao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 09:00:34 +0000
Message-Id: <20260703090034.8EC611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The cond_resched() call in the main loop of ksgxd() was not update=
d to explicitly report RCU-tasks quiescent states, leaving it vulnerable to=
 stalls.
- [High] SGX initialization error path frees EPC page arrays without removi=
ng their physical addresses from the global sgx_epc_address_space XArray, l=
eading to Use-After-Free on hardware memory errors.
--

commit 71875f4f4ed3656160e4c510add3ac4a68c4cd86
Author: Jun Miao <jun.miao@intel.com>

x86/sgx: Report RCU-Tasks quiescent state in EPC sanitization loop

When the kernel boots from kexec, the EPC pages may have a stale state.
The kernel sanitizes all EPC pages to reset them to a clean state before
their first use in any enclave.  The EPC size could be several GBs and
resetting them could take a significant amount of time.

Link: https://github.com/systemd/systemd/issues/40423

> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index dc73194416ac8..545415ee98177 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -103,7 +103,7 @@ static unsigned long __sgx_sanitize_pages(struct list=
_head *dirty_page_list)
>  			left_dirty++;
>  		}
> =20
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  	}
> =20
>  	list_splice(&dirty, dirty_page_list);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the main loop
in ksgxd() in the same file:

arch/x86/kernel/cpu/sgx/main.c:ksgxd() {
...
		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
			sgx_reclaim_pages();

		cond_resched();
...
}

Could this cond_resched() also starve RCU-tasks grace periods if
sgx_should_reclaim() remains continuously true under heavy SGX memory press=
ure?

Since wait_event_freezable() won't sleep in this case, would it make sense
to update this to cond_resched_tasks_rcu_qs() as well?


[Severity: High]
This is a pre-existing issue, but does the error path in sgx_init() leave
dangling pointers in the global sgx_epc_address_space XArray?

arch/x86/kernel/cpu/sgx/main.c:sgx_init() {
...
err_page_cache:
	for (i =3D 0; i < sgx_nr_epc_sections; i++) {
		vfree(sgx_epc_sections[i].pages);
		memunmap(sgx_epc_sections[i].virt_addr);
	}

	return ret;
}

If sgx_page_cache_init() succeeds (which populates the XArray) but a later
initialization step fails, the section->pages arrays are freed here without
being removed from the XArray.

If a hardware memory error occurs later, arch_memory_failure() looks up the
PFN via sgx_paddr_to_page():

arch/x86/kernel/cpu/sgx/main.c:sgx_paddr_to_page() {
...
	section =3D xa_load(&sgx_epc_address_space, paddr);
	if (!section)
		return NULL;

	return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
}

Could this lead to a use-after-free in arch_memory_failure() when it
dereferences the returned page pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703084810.1455=
67-1-jun.miao@intel.com?part=3D1
