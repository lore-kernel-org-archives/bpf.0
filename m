Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794805718;
	b=dkWeB0nMUIm4E+ZySQb9N/cLZnNXuw60dWacb6WIbT2mQPLWdXQQqLRYOkAIrxJvr9H2
	 adX5j51fbP0EWY32Wu14wm0al6lAExmvYYfL8wNSAv2dgYmOE1ViTU1EUDCbxFjTrzl+N
	 q83M4mYqy3NtgIX8oRqHfTzGdhm/CvcQCJ8Dle4rVwoxwNmHE7+ZNeUpYFUYc0CJnmWGL
	 slzjad9VzHe8buOELlcv2vtU8qvAhLF2yRi0eDklsvfiCSFOix8FZADIedrsmky4DXw1/
	 iNI/O+ycKpbj0DRmN5VSoKa/joVA75Ceup7Fyo9oPOHHvNOznE0kRNA2In23EAxiiwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794805718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6PFo0gWJ6YoLoXoUQd+pgr2q8m2qzjFGTHMpGL/07IE=;
	b=MRPORAQ6TAe2RK0bs1OHH1FmFYTXP4QhwooL9zv1CNqA/u6iyLuVZVptAElnVCkU2pLN
	 g3G7BhSyLtJZEeUy9+AAYTuJmhrKZq/K4Ng6Wbc38VG0OuJ8PQxIQtRnzgnUfOFbVBLnX
	 khbMPaAPfYl0TqJBsh2anGwEJIsVRcCS02agzxLjIIaa1bG3gobXEJkD6wPRbhYDCTZKg
	 n+E+4o1m9UF8eKqFVJVh3J4OX7W1WpipJiHPHkxNugXcqKq6VqKYOQMWynwqvHhOlfGQD
	 CTh5dNO5nMCIx+mg7NLhKIx+3yPO/1I12HzhuUe+OvW7/GSSh+e9BFZXi58Y0obdqzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="TSy/b/JZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC4606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDBC4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=TSy/b/JZ
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3acff56a300so26478381fa.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:08:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794805716; cv=none;
        d=google.com; s=arc-20260327;
        b=Iu4RHd7WgqMxH4QXpb5BArbdcx3+yi4LN+ZrtMFbbQHT1yAi1RFpJmvkZM4a3eXrCB
         JTCDz+zLntjb4Xdm5B+FJc/AangChkkzg08hIMwhvK0Pwpa7S2JExBEZUTejgDW0/hXW
         8+wfWhhaGtAVK6KpIBEY4Oi8uRFxxxdhxoYKX30GqeQ/8RAHk+BjvKk4YA4sNp3Fp++O
         wNCfwKjwQxpXrTnWvZM7ZVeXrpTQy5ijxVhWwYa8gfbgmgiST1Tufqi6qWuVga86oNtK
         DHBquiSoxbn8SzTb71iXmBSXXKoqsgmpOult1YFU5PSDQuRlSdA3AMk0dUX0F+L7l1qV
         r1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6PFo0gWJ6YoLoXoUQd+pgr2q8m2qzjFGTHMpGL/07IE=;
        fh=uK93N0giAFMeEJUtpF84lHVkTBgihfHRE6m6LYE3+CM=;
        b=FrSChXIQ2KLKfg2CdWCrrN6jmxg/tG4HfUKuxlI0+q4sHhm7P4GbYld/CH/vsg2xbR
         Yx8MoE2LvhCh3kxhnwugjagJ9ZU2iappzpUoED9cv3o1sONcJ/yjy/7hq52ly4Qk9ZdL
         1H8otLdfj4OB8vbxbOv+o5fLKnyfTSITx9ilQa71aZyz/rGZJIk+lT/lpztiNkZ4Ml72
         OUFPs+jP2B+N86clkIwVpjA9SNSXublXqMtdecF4PgIqFgpKhAvtQDuRz5r3DGJlnxv1
         q9Le4VtW5+NXLAdGUTN8bLhShP4/goUzb/GdbbUkFwmgxcrmppATC/8XHHAIm5rhIH1a
         1Qsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794805716; x=1795410516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6PFo0gWJ6YoLoXoUQd+pgr2q8m2qzjFGTHMpGL/07IE=;
        b=TSy/b/JZ2wjrU2kStbBSWztm4DWLTNtNkuEVQ7pOSonZKkWP0IBhO40JXqIbv6xtsH
         e45tsQPt0CQtbimH33l84TjBbWKqZZwVJaaoirP1b3P4tlG8NPWEhZzxnFoadNR/RSQA
         HbZvJUoOqPIo+01MoNKSbPbdjJ+cu4o4wjkR0tdTx1DHFUws6d310scHTpOwOFlSe5P1
         Bzi0iE3iqbbdP7ibe0LJItvBOj1voUJ8QBqUrMqT5lzFHsub1R1Vz3x1uAmSRscWngJb
         WQs/5c9W8fruwuYsuoTcldvxDHd0rKHjibZeF2KfunYBHPjGXPLuUefltnycSX/n2JMP
         1ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794805716; x=1795410516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PFo0gWJ6YoLoXoUQd+pgr2q8m2qzjFGTHMpGL/07IE=;
        b=EtTTxscVFWebbK/X8SJ37/MjAJwXyQWiJr5998DU5cQ+XB7ZsANGBxgC1k/hiLHxEw
         JhuWA4BBXwI+llBFWoFEoiTntR3DZDkB6lCYXyF/q5WSHCX0FgHJEIZgAljFjrc8CWOe
         aGynh5iolhVZBSLGRExx0pzfgHjdFWiVfOQhJR76XmNmlz3IUk14nT69LBhuLwwD83BR
         lgkmgTYeLw+1zx8zKhtFq+TxxYogsS8Dr9KUb+pMCYWGrZT5eHT2ZYLfVeMpPlT65h0H
         tkoYu/j9necIu8be6b9pkWRPVqAtF+ntODmmt8aPTB0KYtKf2rufS8t86jpxVb9sCCoL
         MAxQ==
X-Forwarded-Encrypted: i=1; AL+hErGuUKxzEFrmsgPTqx8jKnNEjVKSBLLrKuK/1vSbpmeZxnnOFLUcR+cbLpUbf/j4BOt2Qg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U9VaLjhavOwiWxj6ZkdeHnT39NxaZ64pp1DbnBE0OzrzuJ9m/
	NfirxRLmB6bHY+cBa7jnGdi44koRDkOFZY9MzCQ14wnKks5P8aHven+pqzkq4r3HRLiOsELKKyV
	dAnSn7uyv1Y3+qT+ZGjMWWBX672CoMV7EBOhe3l8UKx4=
X-Gm-Gg: AYBFou19vuD7YT9+GlJxcnotc8U4NkLa91OIf4LqmV0v3/ArChQJOeR08Rb7NZaZ7DL
	zPgH/Ob1QB9JyqB1u9dSuqxUqIrLBXGAHEfc995KtXvRM7Q2dPspDWK0ZQNnRKVSnRSijp+fRiU
	4QAjvA194+m/HyJQyJUa/Vv01xtcUuqFj87oXcBNdnmmsNxEbLh5stge0YxFAkmegjNjC/Jg1Qr
	4Q1z+3+YFF+F3kiOZnR8y7PF1Uw5lrJhJ3r7AiI8KSPzGKGBsRulFtcvIQsFHm03FYfU1cpcxSG
	FJkn/Kg40T0Jo1Xq7b4ix/MpaqY3CLhoGai+r85GyFiieMfPfsKFx4QO3Z/30+g0paoUzFaBqz1
	xKHA4dPhdOqwRlVnFUNSiq8pphAkD0y/OPb8HBmSs6OKHC5Ma+3ozpbt93qEN2q5k7/p5ApX2T7
	NlWRH8KCbIVoiDMk4e+YhgVgHEpx4u6cA/E7Zl9uOAoMz4vBsU
X-Received: by 2002:a05:651c:a14e:b0:3a9:c840:10fb with SMTP id
 38308e7fff4ca-3ae2b423c94mr27234081fa.2.1794805715876; Sun, 15 Nov 2026
 21:08:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794759652.git.zihanx@nebusec.ai> <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
 <DMWD65CI6NZ6.2V1UCWL1FUM8K@gmail.com>
In-Reply-To: <DMWD65CI6NZ6.2V1UCWL1FUM8K@gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 16 Nov 2026 13:08:22 +0800
X-Gm-Features: AclHuK8wwX3X6c9X0CotsDoQlCsd788_-OkGc6Jo0WLhdVjqKCwpL8hPjkp3rg8
Message-ID: <CAANe3eSprp-ptkLStFXji38JQitsncoBBYSypRGJ2G5SMghMtg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] udp: fix reuseport rescore fallback
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, benh@amazon.com, 
	kuniyu@google.com, shuah@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 15, 2026 at 07:55 PM Zihan Xi <zihanx@nebusec.ai> wrote:
> > When a reuseport group contains connected sockets, UDP lookup rescored =
the
> > socket selected by the reuseport program. If that socket did not match =
the
> > packet, lookup retained the stale selection while continuing the scan. =
This
> > could deliver a packet to a socket connected to a different peer.
>
> Not since 6.13, unless CONFIG_BASE_SMALL=3Dy.
>
> > Link: https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2|=
|socket-hijack||m7q
>
> That's not a hijack.
> udp_reuseport_add_sock() lets only sockets of one uid into a group.
> A member of the group attaches the prog.
> The prog picks a wrong socket of its own user.
>
> > +             if (need_rescore) {
> > +                     if (score > badness)
> > +                             badness =3D score;
> > +                     else
> > +                             result =3D sk;
> > +                     continue;
> > +             }
>
> This makes it worse.
> The unconnected sockets of a group have the same score.
> So the score of the picked socket is equal to badness, and the patch
> replaces the picked socket with sk.
>
> Sockets A, B, C are not connected. A is the first one in hslot2.
> has_conns is set:
>
>   reuseport picks   today   with the patch
>   ---------------   -----   --------------
>   A                 A       A
>   B                 B       A
>   C                 C       A
>
> Nack.
>
Thanks for the review. You are right on both points.

I missed the 4-tuple hash path added in 6.13, so this does not affect the
normal configuration there; the lookup2 path remains relevant with
CONFIG_BASE_SMALL=3Dy.

The proposed score > badness check also changes equal-score behavior
and can override a valid reuseport selection, as your example shows.
I will withdraw this patch and the security framing rather than send the
current series.

If I revisit the remaining CONFIG_BASE_SMALL behavior, I will first
preserve valid equal-score selections and test both the mismatch fallback
and equal-score reuseport cases.

This series is dropped

Thanks.
