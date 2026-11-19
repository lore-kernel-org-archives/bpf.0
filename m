Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795070451;
	b=hBp7WjsRpDftArtlYd/9Qdcnz8WLKVQdSQxRuP3Fa7LyWqqUFs+jMumGBIuN2RAYt4T8
	 TawkjaFwC+coEEIfvNdrGwwQ4cXbk+zs8vg0aSV8Ks7t8iWuHKNJ1TGk4N1PsdAhzjo3O
	 sbXfAMgPCRhfh9Lt6BKpH+YZIIayRLVpwsHBcc9BfsjWPYVE3i6RlxODLbAKRRe0o0FHA
	 CamEFwcNhCLk6C7cBD5MA34pcc7iKITq+HvVMPdb69yvlNZOBjijrGbanGONIUIBlr3bU
	 MUUANXuTQqKS1J2NqkHYqjyOPmF2EFvkkfTnUoy2n58MMan8ReeKTXsQZG7jLi3kMQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
	b=F9q8hMCk6c3r69S8TWg1ZY+ohFyesQAzl38znnmwbtu6PkCkCnHbDZhDQnxHMBVCDddg
	 K5aNKxHg8WmctfV+mER0IKM3cxOshReFx4btPeRygGgUdgNuPrt1rc7yh7KTPkxwHqnht
	 MtBiDOUsQz1P31hLa66YSBSd6J+xWa0KpiqixYOFKk4Hwpn9yo6Up3BorbpYPNEPJHWwQ
	 hHn/7DZGm3Iq2Ncbs7E6D/si7imHirdXzvbzH6AsjToDWsKtbq6OMluv3cPBKBupxpL6o
	 1TWIZZNZOrRLUQQ9PmzLAlTyfUrqZISkf4Iwuuw8AfX7iaykd5BFwzJtTXHparwUVhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhW3n0Xn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA34606A333
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA34606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhW3n0Xn
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso19837806d6.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795070450; cv=none;
        d=google.com; s=arc-20260327;
        b=ea0OqAlgiAz9CHq3hsodldAY9dkbjcu1jaz3Y+jxD+WUveRSfqPbDMzPOcbia5XfzJ
         2RXmTmiP6bSblAz+5Q4BtEzDs4HiIjLd+5NFXZg8fnqJT452BcD8DZOdepwMueKVF1Gb
         YFngyXszaZ3AppYcaooyBokRFC6e7dgERGI2mmBXk38T4+EIirtn3LY8qkpUk3dDFlXG
         kUKOoTFs3Ovot6LQmBdXrYUPE1J4liDBLX47oPHtfYlymof0CbxSfmraMXdCAEAcQqcE
         elY0fLhhBK9zG5HEEqEhKiy/CZWmAZ+g67XxR5sFGjtZPc53Cg9ZjCeK6tqp3z3uBMA9
         F78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        fh=/o6KX9TZq/Dr4zYC/gBUTVbHEmHQtkWWS+355s9IhGs=;
        b=cGmyX33VXL/pM59vFXReMRmx17xZT5fp4qFPhjVJXkE9x4PJ4Nk9b361w8j5Qf/yVo
         wF3QQnJdrE3dz+6X55hMA7Bxvaw5dF5py6P3ZtW4KofkkTcRt4XiRfI2t0TXGSNd9HqN
         lRY6IZiMgKpFVQwK5APRp71vwciT2rxXKQ47Dh/ONbxMCqMVFDEKhzZlsr2Ak+4F33HI
         8D8o6H/0/Yasi8cYFjCjcl4+0960nIC7mkniLmxkNgkObLz2h1LM4fhQu5QlsbeqnIgZ
         97SG2TvzlSEgtHx8m3KtniWF2YIOXAMu/sPIbkQx2RefQiy0MIBqDR3+0HIhcLAOc3WE
         DgAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070450; x=1795675250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        b=jhW3n0Xn9gARi9x0ofcuuogedfCn+BkFrjDUJgr84m9OvvVHljmtFoB+NmisYI89Qx
         AxW+LKYOzXjgCMDwzV5xLhiLAQoRQDkx/7Zb0ZI9PW9coK/krjPflgtmmdGrsfM3Ba7k
         qoTrz0p2+kHNjZ7TlzXoGYD0rM3H2quwySZAXLqYKZ+T32TWFvJ73oNCZ5oqprHpMKtQ
         4Lu2rPKLV2z1HmFL/YVhjE1JmDivGLCyPSihRVY6zS9OEekq/nD16qOR/yfs6WmSOBNi
         dQq7Us2dlCjpIH2JcAth8AZ/C1Rkq/hSwRLB96GRjVz+5BnKPI0ztsMqUaBheCAyhKiA
         YmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070450; x=1795675250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        b=acqgzfBSnNKnB+TvUgx5IpWZnBWY11tDM6g+AeDDLWdYTzilXEpS9ANtIuPKPcMoPU
         WxRunl6pa3POL5onGA+W3EOs+ga6k/3Dlhfp05Lt9tEBc+lW4zxE23bdOdaY8T4fy7tS
         s2NW2gm46m209/4jaaNjBpYipM1eNY7Q5Ezg3LF32RVJwhv3pcKj3U5muuY3AvZYJZz8
         KpFTcwzd1xPU0koAEayGbHxcjCwd3j9YjZRpb4Fjppwjlf4ixE4rE4JlqIr/rbNRy5O4
         c2bVPgDhIzIPtXpCLwzBy4OqE+TiayxUui/mRY9wTcultAQ43brwNMRYDjEsb5LGrTIX
         Oemw==
X-Gm-Message-State: APuU4Z/8DHoFPr+yP8m1kWiaaXysBC4H9bj312+orIhNH+shnP2Cp1uU
	Rr5/UBPtZINaqBtHokZa0LEgh6W4hJls1PPTnEmDE0jiCK86yzWJZS39dgzId6a0vVigS0h09kb
	IhCwlc1XBIuPFxbg+8RlbrMDfJY8PlA8=
X-Gm-Gg: AZFdTZfhKb1S0PuYr3g7VmtKAAI3BjiAQvoiIpGO/ASeSBe7kaBp9GLu5scPXcwLDpA
	zZ+HS23ZMILrtBLXblXL1XMr8vgvYZJFib3rGDrqHUZENQeoQhAfS62nkwdBCCrtMkwHyR7FQB0
	M/JCPIgUADrt2jPZCvzKdEGWM/s6i3C7EuDjkyanOhPfnheRjWdg6LwQSvjs18lYTIsYNVUFeG2
	Bh2GVd+6g41iLPANT5bIDwXbt4DgGxTnAemwge8CAzGnHhH3MoLAM7Lu1GTgJcjODtlTrxAjC+J
	d0h2ihxgLqbbaNizfRwLslI112FmQtckfSGlHacWkOfd5u8VO0yuuOKtDA8f7dzoMIboJVAZwNC
	7yp3kRNaCeBQ43HIqKKplGRiCZs3M7fMmEptArNYF03t37eIu1BOEwrHrkwWfP3Mtb5cZI5SFt3
	vAINgWhiewJZPNccO4Dw==
X-Received: by 2002:a05:6214:c24:b0:921:25e2:f405 with SMTP id
 6a1803df08f44-92125e2f476mr29167786d6.25.1795070449941; Wed, 18 Nov 2026
 22:40:49 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
 <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
In-Reply-To: <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:40:39 -0500
X-Gm-Features: Aa3M54plz_Orq12J14XfQGfiJZ2U7JU78GoIdc0A9kFDUk3u54uI30c3-_G3pG4
Message-ID: <CAMcAce8VXbawBDJHta-2HneyVW+r3sFmqbFC9=eqCR4tkU5mBQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, security@kernel.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

I sincerely apologize for the confusion caused by my Gmail display name.

I am an academic security researcher, not an AI bot. The display name
on my personal Google account was inadvertently set to a fictional
alias, and I completely understand and respect the kernel's strict
Developer Certificate of Origin (DCO) requirement for real names. I
have now corrected my sender name to my real name.

The patch itself was manually analyzed, developed, and verified on
QEMU x86_64 running 7.4.0-rc3 and 6.12.118 LTS:
- Context: security_release_secctx() is called in atomic/RCU/softirq
context by Netfilter (e.g., ct_seq_start() holding rcu_read_lock(),
and nfqnl_enqueue_packet() in RX softirq).
- Issue: Having bpf_lsm_release_secctx listed in sleepable_lsm_hooks
allows lsm.s/ programs to call sleeping helpers/kfuncs (like
bpf_copy_from_user), which triggers "scheduling while atomic" warnings
or RCU stalls in those paths.
- Verification: Tested in QEMU with a custom BPF reproducer loading an
lsm.s/release_secctx program. Pre-patch loads successfully; post-patch
is rejected with -EINVAL.

I will re-send a clean v2 with my verified legal name in the
Signed-off-by and commit metadata.

Again, my apologies for the oversight regarding the sender identity,
and thank you for keeping the mailing list standards high.

Sincerely,
Yingke Xiao

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B411=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=9B=9B 01:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu Nov 19, 2026 at 6:18 AM UTC, =E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA =
wrote:
> > security_release_secctx() invokes release_secctx LSM callbacks
> > (selinux_release_secctx() and apparmor_release_secctx()), which only
> > kfree(cp->context) and never sleep. Because the hook is non-blocking,
> > Netfilter callers legitimately invoke security_release_secctx() under
> > atomic, RCU, or softirq context:
> >
> >   1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
> >      rcu_read_lock() and holds it across ct_seq_show() ->
> >      ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_sto=
p().
> >   2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
> >      rcu_read_lock() in packet RX softirq and calls
> >      nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
> >      calls security_release_secctx(&ctx).
> >   3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
> >      allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
> >      security_release_secctx(&ctx).
> >
> > Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
> > lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
> > blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/soft=
irq
> > context, causing BUG: scheduling while atomic or RCU stalls.
> >
> > Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
> > line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
> > and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
> > x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch -=
>
> > REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
> > sleepable").
> >
> > Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
> > Cc: stable@vger.kernel.org # 5.10+
> > Signed-off-by: BoBppy <inkxiao12@gmail.com>
>
> This is not a real name.
> I'm dropping all of your patches.
> Teach your bot basics first.
>
> pw-bot: cr
>
