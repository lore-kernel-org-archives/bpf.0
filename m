Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E94E3797
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547250; cv=none; b=iHbaI2Qnk/1+LK1Mwsqo1VMN6Qi0pnUDs4hAJPm40Q9Ms/H2akO6cq5ThFAm+2AZ8/AieY73woaG+F8CNmruCtD+PhFEY1EAF+rHEzSWcyLeo9TRd3xCOdsn3kZ+s8xfhsBRHGhUkNeVJK/tbmEf1gjHN1X2LdjmNy3diohgaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547250; c=relaxed/simple;
	bh=B3HI/g2nBo+Cl0+TxC6lSAGQbJije8A8+z2JXx0/Oco=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PCOvu0lLfXpBeelRn57uAmKFdpbldPEyeBkj4qBsC53gvwR660vvSaC+fuHNULIQHEC5N1uM86VRkhQGQeIyFBOQ28tUWmp1FIf90so970ggo3ao53QVqYvIzFxnM7ugVjppGk7huc6QnGrmv5KdCILh8j2vX3Kev73aQ3nNTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1gFWgMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1gFWgMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0511F00893;
	Fri,  9 Oct 2026 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547246;
	bh=Ge5+2vyfLAoJRhq0HAUKcrJ76EmlrDa9NsyHxcJ/Gzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1gFWgMGaRRmjTHIABrFTzDKG1Xx8SThZElxkOlPjFHsmWGNUTojfz2pwjZmKfeGY
	 /hFE4lZ8ZV6dPIL0NeArnPBZB9Mz7fUbEpSfexiaoR58znbZV6Nkj8eqnRgD+XqwqL
	 hcBervr5MJYELuQbJ+XvtKuQTKPjgxHNp4DPOQO+BmjknXBT+pZ7q+eiuU3bUjA6Rr
	 A8K1B/Er7gshy+PKLl1/Kh84P9kOUMxkTet2eQS0D2HplhmfBhHbFA1TzYo7iSAxji
	 p//r1vDUrb5CvzcqL480mego2ox6mhKiD9Z25Uv8AuslAByEzcSTtnL/H8xYYyl/4E
	 4jEfD3XL/vMhQ==
Message-ID: <sashiko-outbox-165462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] mm/page_owner: add open-coded page_owner iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-4-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-4-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:00:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: buffer overflow in bpf_page_owner_stack_snprint() due to =
missing __sz suffix
- [High] bpf: Panic DoS and OOB read via untrusted stack depot handle in bp=
f_page_owner_stack_snprint()
--

commit f5344767004d7fb48b115dd782835818e60504bc
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add open-coded page_owner iterator

This commit adds an open-coded bpf_iter for pages eligible for page_owner
output. It also introduces a bpf_page_owner_stack_snprint() kfunc to render
the stack trace for a stack_depot handle into a caller-provided buffer.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index 33dc9dcd59dec..80693d4174077 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
[ ... ]
> @@ -114,3 +115,54 @@ int page_owner_iter_register(void)
[ ... ]
> +__bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
> +					     char *buf, u32 buf_size)
> +{

[Severity: Critical]
Does this kfunc bypass the verifier's bounds checking for the buffer?

Because the buffer size argument is named buf_size instead of using the
required __sz or __szk suffix (such as buf__sz), the BPF verifier treats it
as an independent integer scalar. It only validates that the buffer points =
to
a memory region of at least 1 byte.

If a BPF program passes a 1-byte valid buffer along with a maliciously large
buf_size, stack_depot_snprint() will blindly write past the end of the buff=
er,
which can corrupt adjacent stack, heap, or map memory.

[Severity: High]
Is it safe to accept an untrusted depot_stack_handle_t directly from the
BPF program here?

Since the BPF verifier does not track scalar bounds for opaque handles, a
program could pass a forged handle. If depot_fetch_stack() receives an
invalid pool index, it unconditionally triggers a kernel warning:

lib/stackdepot.c:depot_fetch_stack() {
	if (pool_index >=3D pools_num_cached) {
		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
		     pool_index, pools_num_cached, handle);
		return NULL;
	}
	...
}

This can panic systems configured with panic_on_warn=3D1.

Even if the index is valid, a maximized offset could cause the stack pointer
to point near the end of the pool allocation. Accessing the stack size and
entries would then result in an out-of-bounds read past the allocated pool.
This can cause a hard page fault panic, or format arbitrary kernel pointers
into the BPF-provided buffer, which the program could then exfiltrate.

Would it be better to change this kfunc to accept a trusted
struct page_owner_scan *scan instead of a raw scalar?

> +	return stack_depot_snprint(handle, buf, buf_size, 0);
> +}
> +
> +__bpf_kfunc_end_defs();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D3
