Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA85320CB1
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721531; cv=pass; b=XOUYJHpBzVp33AR5t3ZIfC6kci+t9bd1NLLKblH0//RtxPRz9MeimYDtXBeYLTc6gh8XbKN86r0Re6oU1CxCMawAyYZ5mbwpnqnjk5aAp/IBXjByCNkDdnr5Mj1EZ+DFuxFyBRrN8xwv4EcUGZToYHWHvDeG990K8RVx7d/p8HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721531; c=relaxed/simple;
	bh=g8fjNY3YSyzv3MtcGZX+932NsJ3mmzQFtGH2hRcBLTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHVaLiUpfcOsHKPz0ybWxZPQdZCOF/Dte06BVg6wnHYi4GxQtOAPbWmqB3qmGDEv/uq6p+G0j5tPO/aJuVj8xORD/RScI3EjgKPYJ8SZMz83mpPWbVVACS6dEFW8CqLcd+yXcs4xWTp7EXC3i1t5u5EAmFHGg8gQy50oggvq/AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHNFpUPU; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHNFpUPU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84847482584so1029366b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783721530; cv=none;
        d=google.com; s=arc-20260327;
        b=hZRzguTyJyluYinMZsoDpp7SdHAJU+4A94tZEBo6W1l++PQeJLpYC16JvG/V1GrpbH
         CgNQjQD+/c7ms8e7iXM1AKphDR1pWJU1ZO3kylfysOiiy5fgOpidGPKnTTbNw+dA1gYI
         qzksNk53NdtgYFwSUHK322Wqb4QoUvSvbZPNfwNF4N5lnVhmfrFzqD317dHn52oHplCO
         ODKqHKOXN5hUX1Y5SqBcP2oNro1VeyO1Y0TE22FReMDcnE/ctEjUBLBhPJaTEseTTmvh
         72svEpO+4DRekMiPxhThDiklKMmJXDaH6bcVLWChh6k/oeluzialtQVSbGbLGr2B8v1Y
         RTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUo9aFQ2pXsv1o4JFAUjBiYQaHzopddbFAu8p4X92qw=;
        fh=AYXZ3bO46wdVz3Nu3dObWbdSnAZMRerIFAb+H1sZZJ0=;
        b=JuNCaDunWVQu0B+INUpmuXUafd2y/QW3yxzI6PAAYPuQzUh44+x2uolT71uCX4GIKo
         Z2gtaZZwfMZMyTy0izNRgS9k+kioY0b9FqdZuxOiDWm6oQQcv+AOqtI9ziRGQdLAhfXb
         ucq90v3rXx/I6nMaWigCergYjPWHS5jDi3q2gD4RQqyJxabvJtjdkZNecNlVl0iVjT7a
         oBS2po1BQDffrMBFKuvbAn6nvpND8Q9P0TEZ/c9FPdoX2yYRyrw+4NUrgzhyuSJX5KNv
         zbbI+CSeeV4Koupx+i3BlC+xKWftv3vTRpAHpQ+fX8KWC+mJtDJH5qBskdw7Jvv63Oh0
         Rh6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783721530; x=1784326330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUo9aFQ2pXsv1o4JFAUjBiYQaHzopddbFAu8p4X92qw=;
        b=iHNFpUPUXt6huqoH6BU+Q/PxJn4BqEDTPhhAufIg4yuRvbYqcCAmkAqax0dsUU/KfG
         N8Q7r9FSqWhVLWLkzhm2OFH1wlyvTTdg8a6RK/v74Bx6Jg/5xrZflK5i3i6lS7HIkAGw
         uB5XDtISoDK48tWBzUXYMLkTh5zGIqJKeFW/g+vUuKTyBUWoHK9Hfnh30nW+p1Jyk41d
         wVuFR2hke3sr2IrS3qMiO/l4kScPW38/v3OC9MN/iXi8wMAcuZ0s3k2rLTWOr7Ae88e2
         PXBIPCV6adJ6Pva4FGjc89mIzMhmeDDqPlBuISqVCROEZ9HXSmZ1Tot/3oxA0v4mFZnn
         Pidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721530; x=1784326330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUo9aFQ2pXsv1o4JFAUjBiYQaHzopddbFAu8p4X92qw=;
        b=Rj3SZupR2B49L+kDYCLtgFm4pucwaCAF4u87M2ibMV1bYc6YUYWSVFjUNM45O6sAK1
         7fVgDSt/U29DMT5948GkpN7x1VF/bYEma6LmCq6Begz/aSgiYM9M2h9EdU53I2Op2Uri
         0X/2UGXqej8U3OOt4Vluj+mFOI4dFSeMbF5TKprcb/kqOwF37e6+yE1Hiav/FB9inV47
         QvOSIdrkBqzzBQ138s3jdO8rGBdXC1uvd1jQeqPimYPusXb5QzNAk+DwxE77bBYkNkFx
         TIej0pRPQ4jgZn6yb49G4Eak/KmDLTLghdo94662U1aYx+IsnZhO2zZG4ytcxQVLTSqq
         r7Mw==
X-Gm-Message-State: AOJu0Yxmuc7vxP8eJAooFDHCAr0Zti+0leGlsM6biwD+NyqddyGcjcH2
	s5a6Do1j0J91zKbMf/6hQ1GZL9ou9Q+nDECe0U2Qowf0i3FYxrV1ER2leF16xvyMKdW8t0aSNN2
	GPRPHmBa7SzUdPUbB2TDGycrtKl1sNWIx4jjV/NA=
X-Gm-Gg: AfdE7clh2E1FTKCFBdGs/JIVZ1k6Sk5460wS72SQXb2y70g5i4zWiYqWCF/Bcmatunb
	k8TMLYY+DcMi949klHiPQjZMeBqvTWvMlSo8mPhRjJD/5nY9nTQQvGh0/jp+jelCmMl2OYAkVxD
	y+O6pIjRGFhhGuAw9pb6iHa/m7gGZ7frS1LPkl0C+Du1kMP//06lErAISgsNk2sTNZSsGz9gf0I
	3TadVRMVUmihvtx4Jo14JueY6OqZvXhaQ4e6Q3SYMhgMW5dHi1KPnBueTvF6Z2+mp/zb9QslR1S
	BsajNh3usboWseOFC+/093QU9M7+k79wDrbIgy1UYAhKKiAIf4pOxg==
X-Received: by 2002:a05:6a00:9a6:b0:847:888f:9b0f with SMTP id
 d2e1a72fcca58-8488abb38afmr485208b3a.15.1783721529929; Fri, 10 Jul 2026
 15:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
In-Reply-To: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 15:11:57 -0700
X-Gm-Features: AVVi8CfFxh8mnvJBcRCfb11lIjrGuCXZMP71l0o-2HHtUE1_o7Q_3yP4hC_mVvo
Message-ID: <CAEf4BzbQkgT_33qxEJiSxYFR46cw9b2+4sDzq83eBDdWhoAMoQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 8:56=E2=80=AFPM Jianlin Shi <shijianlin11@foxmail.co=
m> wrote:
>
> bpf_ringbuf_query() returns 0 for unrecognized flags, which is
> indistinguishable from a successful BPF_RB_AVAIL_DATA query on an empty
> ring buffer. Return -EINVAL instead so invalid flags are reported
> explicitly.
>
> Update the helper documentation accordingly and document
> BPF_RB_OVERWRITE_POS, which was missing from the description list.
>
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> ---
>  include/uapi/linux/bpf.h | 3 ++-
>  kernel/bpf/ringbuf.c     | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b76..b18d5810d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4664,13 +4664,14 @@ union bpf_attr {
>   *             * **BPF_RB_RING_SIZE**: The size of ring buffer.
>   *             * **BPF_RB_CONS_POS**: Consumer position (can wrap around=
).
>   *             * **BPF_RB_PROD_POS**: Producer(s) position (can wrap aro=
und).
> + *             * **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap =
around).
>   *
>   *             Data returned is just a momentary snapshot of actual valu=
es
>   *             and could be inaccurate, so this facility should be used =
to
>   *             power heuristics and for reporting, not to make 100% corr=
ect
>   *             calculation.
>   *     Return
> - *             Requested value, or 0, if *flags* are not recognized.
> + *             Requested value on success. **-EINVAL** if *flags* are no=
t recognized.
>   *
>   * long bpf_csum_level(struct sk_buff *skb, u64 level)
>   *     Description
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade..e549acdc6 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -656,7 +656,7 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, =
u64, flags)

bpf_ringbuf_query() is defined as returning u64, so this -1 is 0xfff...fff.

I think it's fine to keep it at zero. There is no confusion for
BPF_RB_AVAIL_SZ, if you provide correct flags (e.g.,
BPF_RB_AVAIL_DATA), then zero is a valid value, you shouldn't
double-guess anything. For BPF_RB_OVERWRITE_POS (yes, please send a
doc update as a separate patch), on older kernels you will get zero
because kernel doesn't recognize it, but if you are relying on
overwrite_pos, you won't be able to create BPF ringbuf anyways.

tl;dr, yes, it's not ideal, but zero matches better with the semantics
of this specific BPF helper, this was done intentionally back in 2020
and is not an omission.

pw-bot: cr


>         case BPF_RB_OVERWRITE_POS:
>                 return smp_load_acquire(&rb->overwrite_pos);
>         default:
> -               return 0;
> +               return -EINVAL;
>         }
>  }
>
> --
> 2.43.0
>
