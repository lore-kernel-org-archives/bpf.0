Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CB51B17D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065504; cv=none; b=ETXFS2dUUv1j4NFcxtVIU2he/nVaXxvEWzpogpEQA7+1MqDMuYgxgc2bSQSolFSi6/QOh3kBB25irwV+w2V8We1jehiQ9S36PEcUH2orwn0o6WQmAh+biqHhSvsrgKF/gV2zwm0b2XWtd8CarcAI5kmPRtIhB9pDyR+2Ittp62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065504; c=relaxed/simple;
	bh=aDoDFWj9bYtwQ1ZlXXA79J5N00JRc78+gHj9Y6EV040=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=kGrVB8plIcXiTAkHRZa50eN49KHiHflcBQyRmz9ROZwZpvLIfDE0oLe1g1CYzYoFpPQZLqjFUOkoP/9Ni1dAwRBnWRKrbwkHImjP1SmuSqU2wDg/8kdhFTZssZVHxsLLo8YXlfSpz4qNCflqs4Rdw655SRxlxj6VX/Cd+3xBXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt4G5Vbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt4G5Vbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8033C1F000C4;
	Thu, 15 Oct 2026 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065502;
	bh=L0f9kTIQxbVTFefdYGRYm5vXEKFvRnki00lzE5HaNPQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Pt4G5VblA7XlH4xIm63XEaObutiywGQERxL2bcLz1tKPRtyVUgrjTNg5oSkyMpx1j
	 E5wQFnKttee1/DYO5Lpxa31/NQOmNjwFwILujJZkKhbOj+9RILD5WcM/yAWTBdFsb0
	 pHOqGWIc6ZQjiAW417hOkkJAT2rldWcBiSEvFI+NxTNyr6zTsFdzhwLwg52Ztkn4M+
	 CtU7m94n9Eg9qbExWxTUQCeyEq9t2Rp6a3f+Bfp6RXtUwVboW7p3YhNfGJMfmTUdVQ
	 9nlSEAspFYCKPS9UjgujyN/eAPyqHXcCSC+0ZVpTK7ab6glcarlzdmE9T7q129flhQ
	 yoN6/lXSNKQ7Q==
Message-ID: <sashiko-outbox-172775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion
 control access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
References: <cover.1791978740.git.zhilinz@nebusec.ai>
 <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:58:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: Commit message describes impossible exploit vector via bpf_=
rdonly_cast
--

commit fc4f1a419dfb22513647d5927643a1274a3968ac
Author: Zhiling Zou <zhilinz@nebusec.ai>

bpf: reject unsafe pointers in TCP congestion control access

This commit adds a check in bpf_tcp_ca_btf_struct_access() to reject
pointers with unsafe modifiers. This is intended to prevent BPF programs
from using bpf_rdonly_cast() to create untrusted tcp_sock pointers and
modifying allowlisted members.

> bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
> and member offset, but does not check pointer modifiers. A BPF program
> can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
> write through an allowlisted member, bypassing the read-only cast.

[Severity: Medium]
Does bpf_rdonly_cast() actually allow this bypass?

bpf_rdonly_cast() produces a pointer with the PTR_UNTRUSTED modifier for
structs. Looking at check_ptr_to_btf_access() in kernel/bpf/verifier.c, the
verifier natively rejects BPF_WRITE access for PTR_UNTRUSTED pointers before
the bpf_tcp_ca_btf_struct_access() callback is ever reached:

kernel/bpf/verifier.c:check_ptr_to_btf_access() {
    ...
    if (atype !=3D BPF_READ && bpf_may_fault_on_deref(reg->type)) {
        verbose(env, "only read is supported\n");
        return -EACCES;
    }
    ...
}

Because bpf_may_fault_on_deref() returns true for PTR_UNTRUSTED, wouldn't
this write already be rejected by the verifier with -EACCES?

> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 791e15063237c..252cbfe11e694 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -65,6 +65,11 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_ver=
ifier_log *log,
>  	const struct btf_type *t;
>  	size_t end;
> =20
> +	if (bpf_type_has_unsafe_modifiers(reg->type)) {
> +		bpf_log(log, "write through an unsafe tcp_sock pointer\n");
> +		return -EACCES;
> +	}

[Severity: Medium]
Since PTR_UNTRUSTED is blocked earlier, is this code unreachable for the
bpf_rdonly_cast() vector described in the commit message?

It appears this change is still valuable because it prevents writes from ot=
her
unsafe modifiers (like MEM_RCU and MEM_RDONLY) that don't trigger
bpf_may_fault_on_deref() and would otherwise be improperly permitted by this
callback.

Could the commit message be updated to describe the actual vectors this cha=
nge
protects against, rather than the impossible bpf_rdonly_cast() vector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791978740.gi=
t.zhilinz@nebusec.ai?part=3D1
