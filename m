Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A62EC54A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516412; cv=pass; b=uKp8CrBlmE5KS8LNTlwBuN2f+dZIZzQKJT/BGDS1xLvCMDTihoUMu4NCTQQWTRHqBseIhOMGGRGMMsOq2y58hHExRrMeygADt/tcttxhTFRLSnE6LDaeHL5Wua+tNNKkcTAY+QpTDZ3a3HjGJr8bIxJurx25B8h16xhQ66R6s9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516412; c=relaxed/simple;
	bh=/e7hkDx42vRtWDDOFUhleCLIb/wxE/G7l9fKSe2NWS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhG97wGePZ0TFXsUKN7EVRtyFsBtyVSscO6+nn5Zg6F64uwAfaeffWFTj0vMPI9w9t0gqWI9sQ5OwNWFhkXgyXw6hfy0xU5EVEwsXPWhTjtHK+hqet0SsLZA3lJiZwmaTEeQjHR39gIy1z01izySPUYQke5q6bPfqmsEbnXgpMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQStYnoi; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQStYnoi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f9568e074so114261266b.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 02:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774516409; cv=none;
        d=google.com; s=arc-20240605;
        b=DGVxKKubGK4stLW4EAYHC8ASky1oVkMnwgabQeDZrnMKcFrpUHAcJLdozeL5EIRCCB
         oujDByAmXqNNc+S8rH+8yEIftFbkLfYMgy7QCVCwfGQX2NVOYpBd88bCpxSqrK8lPF3O
         3Nr6PamNPUUBv7v8mVTb3w8c4j2u+mggsZtfUIE3nxtY5idMNRgzGWVNRKXrhHNFLYkF
         F4+VKAsMEGa0q7ltT7wtMBKToCAG5vDmsrcD6PjHNVOlSaJZcEi3UgZjqCSIUW1UppsE
         5fave9wQ6gQrHcWQobZIK8Jdt2+r/W43BljZhwwXhQLF+WCJqzrhqaqucoIeuwloihXW
         YxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UGB46r+Oixa13owbku5fmyOSlID64cowrqEeRMzZxSw=;
        fh=kgRp5VWqnb+R1VaC6eqio3iVft5+kpalc+14mahCSvE=;
        b=DWujOs048JrgGU/1uC8x+4X1vRkPBCtytgunpKYwdT+FO+00RTIZ0OaBPrQjhht/9B
         1PIhEINYI5y+YXRRQ6RYiMzoKqvgTPIOSDqrj/XSr7PNMVqgAmFJbgShlNDe40qSBZoB
         4+sajvNT8B4SeF3MTjI/BgF2FEK2rE/QGWzyHnbXiw7sr70mm9c3d3v1BfbSUBxsJ20K
         efIAOYJCqLrHqrkRoD4MIP706lPy5OfEIaqxown2Y8uTqgh3Td1zhicvvpHPEWZPHIl3
         o1wIdtG4yZoDrJhgMb/tRTNk+Z4Ze7FiVm1uy3HmdrbPREJSMbxzCBeJrd8tjIc1YWgf
         ipfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516409; x=1775121209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGB46r+Oixa13owbku5fmyOSlID64cowrqEeRMzZxSw=;
        b=AQStYnoiYn7++IuHZ6S0dKs06EEBFdznqpaWJ6OyOppiUmYuY+9ldQkc4kih3mlXF9
         c/PUYM7OaVMDkmeBYab3ju6lcoxv1BfY+xIdVHBuRiR5POdft0C08EGcPPtbcMQrw5fR
         JswrgPk9i2DSkiY5dCYhWNfM6uVJeCWmLV6OkigoSLMtMTY8mOmlL343Yh1xn7QPUtWP
         czUh64+RCCVQZ4TKSHWipalocHEveEocKu1Ip1qbw1ZZzSUoex1Fene/iPrSmpIUNczP
         tM6ggCq+/lzN0Q1zfLt+jfQWuCnCqmy9oQpfNjZk82fuSW6/MmdB5Tnxd9w7iS5UvJO+
         irWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516409; x=1775121209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UGB46r+Oixa13owbku5fmyOSlID64cowrqEeRMzZxSw=;
        b=at+v4gDnJtF7yKks3SZEgbP572vCwbT8KxQ6S9dMG4UaLWt0JkUgQBUYJ7U79mCaVX
         phtKGpup3Cv4KPlTsqqDVbkOQmM0MY86o6RT9oFFbhFqe4+mAoZlYSwn8guo97YkFI7t
         HAIjdQ8Jx8cFmKeBYuohaXd/w3Vmhpp066oE3Alz1K4hsOsvzGgOrsCv82AAd+Wj6JK4
         U3Ht+IgtP2jxKoeG+Ly9Xl9f+UqrltmTXNFZJ948msHmm9/TWyDE+gHM6YB9Ep+W69ji
         9z5xSrN9xe28W57oFCb07JUO3ZKLu4CTsz6pR0r/MMTZQhO1MOtxYX6k7YJqjze3PCN0
         BeAg==
X-Gm-Message-State: AOJu0Yy/mhe2aCQj3lzYqvgwQiYfMFmkAZ4bBCuTss8sJk0xP2mWA24O
	WvYRpG90YgTq8LG5B9zI7aC0ruN5QBiV5GF1Zlx5Kd4ysjUrzm+eRzq+Afl2ToTRRZWIXuZliFK
	k14kl/nYE3Cz+yI0r84h41EZAm54H4OU=
X-Gm-Gg: ATEYQzx07ylzJxDGr+o6LUfYvC5fqleZh1rCZIly1pWFnTRfGMo5MI/UZckImBW8rTq
	GipxRHVksOSNR/to/RqaPYKp4BjH4+75RhZd7Y6nf6gLNiAtxZhu0JW7y+7eMjwpBgKSo3Wg5QI
	gzwPQEYF7wVTftow1GK/A5vKaT+5x9xsz7WFQFropfW/jelTxKjYLYzS0bvYCWCg0makz0qP5my
	IbvDfW9kq1SJtWvTBYGQMeVfDWhW4hXRBCXmKAliWvIPr6u93GKlkQViJMLWe4QiB5u84J5NUEI
	NS36jHVmDHGqJaZQSdkcCg4=
X-Received: by 2002:a17:907:388b:b0:b9b:1f3e:fa56 with SMTP id
 a640c23a62f3a-b9b1f3efbe5mr180626966b.45.1774516408681; Thu, 26 Mar 2026
 02:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn> <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
In-Reply-To: <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 09:13:17 +0000
X-Gm-Features: AQROBzCGa_087vSfATHHc_29FLzSjDbii7bmguaEsV0tZ7UebZJRUkDWVF4L2Gw
Message-ID: <CANk7y0gKbC22yrsBec_6JmyLSN76eTshcX2_W_zhSYSgXkenxQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:08=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Thu, Mar 26, 2026 at 9:02=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.c=
n> wrote:
> >
> > From: Yazhou Tang <tangyazhou518@outlook.com>
> >
> > In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
> > the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
> > (e.g., call_imm > 32767), this silent truncation causes find_subprog()
> > to return an incorrect subprog ID, which is then stored in insn->imm.
> >
> > Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
> > fails to resolve the subprogram name, and incorrectly displays a raw
> > kernel pointer.
> >
> > For example, dumping the xlated bytecode of the JIT-loaded selftest
> > introduced in patch 2/3 (call_imm =3D=3D 32768, i.e., 0x00008000) shows
> > that it is truncated to 0x8000 and reinterpreted as -32768 in s16:
> >
> > Before this patch (with call_imm > 32767):
> >    4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
> >    5: (85) call pc-32768#0xffffffff814aed4e
> >
> > After this patch:
> >    4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
> >    5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog
> >
> > This patch fixes the issue by passing the un-truncated 32-bit
> > env->insn_aux_data[i].call_imm directly to find_subprog().
> >
> > Note that the assignment to insn->off is retained. Although it still
> > truncates for large jumps, it remains correct for the vast majority
> > of BPF programs where the offset fits within s16 bounds. Keeping it
> > ensures backward compatibility for existing user-space tools that rely
> > on insn->off to display the relative offset. A comment is added to
> > explicitly clarify this truncation behavior.
> >
> > Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> > Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in=
 dump")
> > Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> > Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
>
> Yazhou, you should wait 3-4 days before sending the next version of a
> patch(set) and add a changelog so it is easy to see what changed
> between versions. For single patches you can add changelog below the
> "---" and for multi patch sets, you do it in the cover letter.
>
> Thanks

I realized you do have a changelog in the cover letter, but you only
cc-ed me in this patch and not the cover letter and other two patches.
Anyways, I have seen those two patches from the list and they look
good to me so you can add Reviewed-by: Puranjay Mohan
<puranjay@kernel.org> to them as well.

Thanks
