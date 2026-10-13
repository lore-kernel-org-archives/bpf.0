Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAE51AED7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902984; cv=none; b=FhoqApuqxHoqGif4uMAH6XDXV/YOZ3Ur1aM9vL4NG2WraP1diEK5+GiPoy3Mf2xQJhftEV/nLBAX3w88adA2m1FCqVZBSwH3OrEFuDWf2uRUvfpeeKf+b8JL5ZIauNdl8jPEkU60BW4oqptIqmfeCAjMbWiXwZ9yWsYBioGD21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902984; c=relaxed/simple;
	bh=BhmRNXs0BMAiFB/X411H6kYECTQO0wgVJWPLH71Kl/I=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=AERg3nfkoVM2NTEngowQqk0qkETsBto7oY7MoM53w0D4D0QKJEjeaF2i+F1XVksFFWCGKh6QqtKm+hmDiKuDUI7QOo1q4TkxXxOxt08zrvtuo8EokJcNvFfdqgfOB2UOHI5iOZnbdH7x/CeRs3e+1j0V0sBjY2N0fhT/yxZxHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqGlD5EX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqGlD5EX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C61F00893;
	Tue, 13 Oct 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902983;
	bh=lnJrOGFsqebjMRbgrE11MZ3pv0upw9HgJN5ZramjNwQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OqGlD5EXwiDJHobufJUpt9iRUI7QCcWoZFQbaYJoNDvQF94V8PZfVZCFuCemkNj7z
	 0vrGfuc28FwBxC2hpQy0HokJ6I8UETz0lrABrdGfQTgMZd4lg9hlVSBko4BxkJ8MTL
	 XGMXjTFWFCzgaxbn+3LjKUC15WtvCngjbjNTp3muZbm1mvD07TJWvtqUlZG8zFdj3n
	 6bayEpHVku4Bv4WbesM8PC+eBw4NrroWDQXyFA6b2BAtBG6bAhp6CodrIjqyRQveby
	 Fnp8/UAQ09SQWezxa6ynNxprbV1xoNEFhvgYPO/8n3bjDxkJV75InI7URcS0Y8TQ6z
	 RwV0PIsXoDs5w==
Message-ID: <sashiko-outbox-169941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Add tests for memcg kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: listout@listout.xyz, bpf@vger.kernel.org
In-Reply-To: <20261013143853.1379307-1-listout@listout.xyz>
References: <20261013143853.1379307-1-listout@listout.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:49:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing negative bounds checks in memcg event kfuncs allow OO=
B reads
--

commit fbb677e1e6cb5f158ac286d23535b8f06e966597
Author: Brahmajit Das <bdas@suse.de>

selftests/bpf: Add tests for memcg kfuncs

The existing cgroup_iter_memcg test covers bpf_get_mem_cgroup(),
bpf_put_mem_cgroup(), bpf_mem_cgroup_flush_stats(),
bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(), but
bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
selftest coverage.

Add a memcg_kfuncs test that drives them from syscall programs against
a test cgroup.

> diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs.c b/tools/tes=
ting/selftests/bpf/progs/memcg_kfuncs.c
> new file mode 100644
> index 0000000000000..3c7866730aa0c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
> @@ -0,0 +1,101 @@

[ ... ]

> +SEC("syscall")
> +int memcg_query(void *ctx)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	memcg =3D memcg_from_cgid();
> +	if (!memcg)
> +		return 1;

[ ... ]

> +	/* Out-of-range indices must be rejected with (unsigned long)-1. */
> +	bad_memory_event =3D bpf_mem_cgroup_memory_events(memcg,
> +		bpf_core_enum_value(enum memcg_memory_event, MEMCG_NR_MEMORY_EVENTS));
> +	bad_vm_event =3D bpf_mem_cgroup_vm_events(memcg,
> +		bpf_core_enum_value(enum vm_event_item, NR_VM_EVENT_ITEMS));
> +	bad_page_state =3D bpf_mem_cgroup_page_state(memcg, -1);

[Severity: High]
Does this test expose an incomplete bounds check in the underlying kfuncs?

The BPF verifier treats enum arguments as signed scalars and does not
restrict them to valid enum ranges, so BPF programs can pass negative value=
s.

In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events(), the signed check
event >=3D MEMCG_NR_MEMORY_EVENTS is bypassed by negative values like -1.
The function then indexes memcg->memory_events[event], leading to an
out-of-bounds kernel memory read.

Similarly, bpf_mem_cgroup_vm_events() delegates to memcg_vm_event_item_vali=
d()
in mm/memcontrol.c, which checks idx >=3D NR_VM_EVENT_ITEMS. A negative ind=
ex
bypasses this and accesses mem_cgroup_events_index[idx] out of bounds.

Could malicious or unprivileged BPF programs exploit this to read
out-of-bounds kernel memory?

> +
> +	bpf_put_mem_cgroup(memcg);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013143853.1379=
307-1-listout@listout.xyz?part=3D1
