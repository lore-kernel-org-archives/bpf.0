Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA026ED41
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012133; cv=none; b=JjIBwrFVYCo7kd1TqVs9y1yL1g5V3gwU76pIO5fhDqAreKlINvrlypP4bcXX0mOnef8ouKIr/CgcYLNpYTvrE/peOp2isZfMJuJ1RShL0zLqmtNTnG3v/wNc++S2GONmcg4HQ4VchzNatsl0Y32bKwgU5zpPDkoQzfnn015sizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012133; c=relaxed/simple;
	bh=lRFB10J3W7dkzbx+5UnZQmQXfdmjFmWBTtJDp4+fZsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtVhAwGMCUoTtx52yzqS6rYZm/FPPxjJNYdpmEkFKRwBlEHdVsOIsuZwsP/unJydejkRmvZr5KW2PsIz1f4138uwCBvLftWzmFliZ80w4CUqcuTu+iQQapizbSrwfodC2JU46ZCl8/WxcaH8gDJeHCGuvZmsJCpv9fysW0MWx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhGZjJzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhGZjJzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E6AC2BCB4;
	Tue,  5 May 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778012132;
	bh=lRFB10J3W7dkzbx+5UnZQmQXfdmjFmWBTtJDp4+fZsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mhGZjJzq/h0f3Tfwq9GBTS7bLovht2OQzLnYs0PPfgmnw3snXMm8VwtCNnUGSY4j2
	 4M3aODUtu9lQk4inlUBAD1OrnIMDq9ityvih8kEHHlJaPY69TqwPIZ0NWi0dhNcrje
	 vLHzqcvwM/SMYSkxMryUArYQy/YGwQ4gTVaNdhiP7n9+eV8hGEtVIB7iyd6rU2+dWH
	 nBxgxGdT7KR4iwFxIXncSGdIs/3rlQEVqMptNzIL02nrzeRDHldi9zKBllaN78C7Im
	 3Vy9KQBUKKy1raJQ7wc4JPfq+ztsYdT3xoC9CaJ4+0y5FbK8hogbWsIBa+b+HLZkus
	 k0epZgozH5eaw==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next v2 2/2] selftests/bpf: Add kptr destructor NMI
 exerciser
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505150851.3090688-3-utilityemal77@gmail.com>
References: <20260505150851.3090688-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 20:15:32 +0000
Message-Id: <20260505201532.A1E6AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Read-modify-write data race on `kptr_dtor_nmi_live_mask` between s=
yscall and NMI contexts.
- [High] Non-atomic increment of `kptr_dtor_nmi_release_calls` in a global =
fentry hook leads to lost updates.
- [Medium] API Contract Violation: Incorrect BPF program signature for the =
`tp_btf/nmi_handler` tracepoint.
- [Medium] Test flakiness due to reliance on natural RCU grace periods and =
a misplaced `kern_sync_rcu()` call.
--

commit cb04c2d31ab28ab2b4ff2bbc2cd6c029cabdc851
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Add kptr destructor NMI exerciser

Programs attached to tp_btf/nmi_handler can drop refcounted kptrs from
NMI context by deleting map entries or clearing map values. Add a
dedicated BPF-side selftest program that populates hash and array maps
with cpumask kptrs and clears them again from the NMI handler.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c b/too=
ls/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
> index 0000000000000..a1aa8b6646b36
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c

[ ... ]

> @@ -193,12 +193,12 @@ static void run_kptr_dtor_nmi_case(const struct kpt=
r_dtor_nmi_case *test)
>  			       "kptr_dtor_nmi_setup_created"))
>  			goto cleanup;
> =20
>  		if (!wait_for_nmi_drain(skel, expected_total, expected_total))
>  			goto cleanup;
> =20
>  		kern_sync_rcu();

Is it possible for the test to flake here due to relying on the natural
background RCU grace period?

For hash maps, deleted elements are freed and their kptrs are destructed via
RCU callbacks, which increment the release calls counter. The
wait_for_nmi_drain() loop waits for up to 5 seconds for this counter to hit
the target, but we only force an RCU grace period with kern_sync_rcu() after
the wait loop completes.

Under heavy system load, could the natural grace period take longer than
5 seconds and cause the wait loop to time out?

>  	}
> =20
>  	if (!run_syscall_prog(skel->progs.cleanup_kptrs, "cleanup_kptrs"))
>  		goto cleanup;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c b/tools/te=
sting/selftests/bpf/progs/kptr_dtor_nmi.c
> index 0000000000000..1ab5951a7a223
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c

[ ... ]

> @@ -66,15 +66,15 @@ static void set_err(__u32 *err_dst, int *errno_dst, _=
_u32 err, int err_no)
>  static bool slot_is_live(__u32 slot)
>  {
>  	return kptr_dtor_nmi_live_mask & (1U << slot);
>  }
> =20
>  static void mark_slot_live(__u32 slot)
>  {
>  	kptr_dtor_nmi_live_mask |=3D 1U << slot;
>  }
> =20
>  static void clear_slot_live(__u32 slot)
>  {
>  	kptr_dtor_nmi_live_mask &=3D ~(1U << slot);
>  }

Can this sequence cause updates to the live mask to be lost?

Since kptr_dtor_nmi_live_mask is updated using non-atomic bitwise operation=
s,
if an NMI interrupts the syscall program exactly between the load and store
instructions of mark_slot_live():

syscall context (mark_slot_live)
    loads kptr_dtor_nmi_live_mask
    <NMI interrupts>

NMI context (clear_slot_live)
    loads, clears bit, stores kptr_dtor_nmi_live_mask

syscall context resumes
    stores modified mask, overwriting the NMI's cleared bit

If this happens, the NMI handler on subsequent runs will encounter an
already-deleted slot, fail with -ENOENT, and permanently abort the loop.
Should these updates use atomic builtins like __sync_fetch_and_or()?

> =20
>  static struct kptr_dtor_nmi_value *lookup_hash_value(__u32 slot)

[ ... ]

> @@ -375,12 +375,12 @@ int cleanup_kptrs(void *ctx)
>  		break;
>  	}
> =20
>  	return 0;
>  }
> =20
>  SEC("tp_btf/nmi_handler")
>  int BPF_PROG(clear_kptrs_from_nmi, void *handler, void *regs, s64 delta_=
ns,
>  	     int handled)
>  {
>  	(void)handler;

Does this signature match the kernel tracepoint for nmi_handler?

The nmi_handler tracepoint in the kernel has exactly 3 arguments: handler,
delta_ns, and handled. By including a regs parameter here, the BPF_PROG
macro maps delta_ns to ctx[1] and handled to ctx[3].

Since the actual context size is 3 elements, accessing handled would read
out-of-bounds. Should the regs parameter be removed to match the tracepoint?

>  	(void)regs;
>  	(void)delta_ns;

[ ... ]

> @@ -402,10 +402,10 @@ int BPF_PROG(clear_kptrs_from_nmi, void *handler, v=
oid *regs, s64 delta_ns,
>  		break;
>  	}
> =20
>  	return 0;
>  }
> =20
>  SEC("fentry/bpf_cpumask_release")
>  int BPF_PROG(count_cpumask_release, struct bpf_cpumask *mask)
>  {
>  	(void)mask;
>  	kptr_dtor_nmi_release_calls++;
>  	return 0;
>  }

Could concurrent global calls to bpf_cpumask_release() cause lost updates
to this counter?

This fentry hook traces the function globally across all CPUs. The counter
is incremented non-atomically, which translates to a load-add-store
sequence. If bpf_cpumask_release is executed concurrently on multiple CPUs
(e.g., when running selftests in parallel), these increments can race.

If an increment generated by the test itself is lost, the test will fall
short of expected_release_calls, causing wait_for_nmi_drain() to hang and
time out. Should this use __sync_fetch_and_add() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505150851.3090=
688-1-utilityemal77@gmail.com?part=3D2
