Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02A1F09A8
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927919; cv=none; b=dQWZGhjLrekNd/mMREIzAHUFdJJtO8xEk56K04RnFLGd9/EnQiRZaDPnH5B6C1dzTncHPAVwMC3F0GEZxC0+5U7vb/tZVU1q7b4l7pB7iCR9fRHsAKc+r6QYmT0H0NmqNPJTJXxtM//1WNycAodiNbjRGXMrlvr40GafdpZ8iXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927919; c=relaxed/simple;
	bh=npFHsIr0gNk5PXCDhNnvNIS3NbkyIdvyxt2/44U0NUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b7S0KVRhCblnuo9Y6OTOYUcjpbwPaAqt23ZouDlgsIThEwX5zq3Ap2vt4Phi0VydTu1A6M09SHpxBkfEUCjvhUCklcEFmAF1CAIzUi5rUoCDSETDb8EeyjLczeo/syHrfw2Nwemd+VQplLe8gBvcK2fjKR9RGEEyDhv+5uNE72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjyfVzfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjyfVzfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C420C1F000E9;
	Sat, 20 Jun 2026 03:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781927918;
	bh=bCuTt+DpBCzx+48DRD1BmBxQy7SlzLSZTuIF7Zu8clA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjyfVzfbAWTrpT2o9lzTWa96HbkGe/U3uPVcGBzVTXwMzMTNRpxJfjmlVSIGLvbtp
	 UVffRj+n1/zF6sL4/aIEo89muudP1u0DVNQBYRvDsphp+HwsNQMyESNlI7rEjoDzNp
	 yz4AwYA+liFa+Ml+9a4ipfIv/6G3bMpPRprhEwIl3g+BZQedvlv6iHIliwGZhufbZF
	 XPoIAo1Aq6ePZ2JbYhN8teONBmuDV3Vn0qTM0TB+KXFupHWk9fN0/cbLHBdUpFpmgG
	 5z/3kOrS/mIMqSgEnLrvG3aYleR1hHKuXItOtnFMGUIk6+w7VMp1tnVHuec04CcNwX
	 RwxacD0xS/85w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: disallow update and delete from
 tc, xdp and flow_dissector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
References: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 03:58:37 +0000
Message-Id: <20260620035837.C420C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The commit silently breaks multiple existing BPF selftests by reje=
cting sockmap updates from TC, XDP, and flow_dissector programs without upd=
ating the tests, indicating an incomplete patch and a breaking UAPI change.

Pre-existing issues:
- [High] The patch incompletely fixes a circular locking dependency between=
 `sk_callback_lock` and `stab->lock`. While it removes `BPF_PROG_TYPE_SCHED=
_CLS`, `BPF_PROG_TYPE_SCHED_ACT`, `BPF_PROG_TYPE_XDP`, and `BPF_PROG_TYPE_F=
LOW_DISSECTOR` from the allowed program types in `may_update_sockmap()`, it=
 fails to remove `BPF_PROG_TYPE_SOCK_OPS` and `BPF_PROG_TYPE_SOCKET_FILTER`=
. Both of these can still be executed synchronously on the exact same egres=
s path, triggering the identical deadlock.
--

commit 44025f27fc1d4e7065cdd08d5667a66505bcb5cf
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector

This patch removes the ability to update or delete sockmaps from TC, XDP, a=
nd
flow_dissector BPF programs. It aims to fix a circular locking dependency
between the sk_callback_lock and stab->lock that occurs during the egress
path.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281c..612b264439c6c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8452,11 +8452,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>  			return true;
>  		break;
>  	case BPF_PROG_TYPE_SOCKET_FILTER:

[Severity: High]
This is a pre-existing issue, but does leaving BPF_PROG_TYPE_SOCKET_FILTER
(and BPF_PROG_TYPE_SOCK_OPS just above this) allowed here still leave the d=
oor
open for the same deadlock?

Both of these can execute synchronously on the exact same egress path you
mentioned in the commit message:

sk_psock_strp_data_ready()
  tcp_bpf_strp_read_sock()
    __tcp_cleanup_rbuf()
      tcp_send_ack()
        __tcp_send_ack()
          __tcp_transmit_skb()

Inside __tcp_transmit_skb(), bpf_skops_write_hdr_opt() can execute a
BPF_PROG_TYPE_SOCK_OPS program. Alternatively, dev_queue_xmit() can call
dev_queue_xmit_nit() if an AF_PACKET socket is attached, executing a
BPF_PROG_TYPE_SOCKET_FILTER program.

If either program updates or deletes a sockmap element, wouldn't it acquire
stab->lock and recreate the sk_callback_lock -> stab->lock dependency?

> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
>  		return true;

[Severity: High]
Since this drops support for XDP, TC, and flow_dissector, are there updates
needed for the selftests in tools/testing/selftests/bpf/progs/verifier_sock=
map_mutate.c?

That test file explicitly expects success for xdp, flow_dissector,
classifier, and action programs performing sockmap mutations:

SEC("xdp")
__success
int test_xdp(struct xdp_md *ctx __always_unused)

Will this change cause the verifier to reject those programs and fail the
test suite?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620034632.2308=
-1-rhkrqnwk98@gmail.com?part=3D1
