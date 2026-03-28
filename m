Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41A3783C3
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705209; cv=pass; b=iPYnpKo14F8GB9uouGnlnqx4w+YmRg/WP2UBZsU06WKlCmmBM76YcBhKLzAoyxx3hZq/PjYlFlMpP1czZqyb0X4DrAx+K8bh+Yt/WEFng/dDRtvTqbxEs3KlbBbNUoGzC5XcEuR9L9YxhkjXm7dUj7wMpsTRxk6O0rmo4pHNSgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705209; c=relaxed/simple;
	bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jme3eauz3aJ7P7XNSqlXEq/8cAbPtUw8a6j8oikKF4RW1Y1Am66M+zw1cgENxVqKVKWp0Xq55wns+Ijg0dAGy1iZMPj4cAY+UEscY5fiAkbeDBPWL+0QmBsJABkGOdbnah7XdmyNsk/jQMHUouAu9LNURkx6pyrRTvGi4HkebK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDEvyPuV; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDEvyPuV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296d553142so1507037b3a.3
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774705207; cv=none;
        d=google.com; s=arc-20240605;
        b=VI6QkshRZrcBm3SjMAXkEXalmd95gZ2t1d9dkrC97vB+mGWPcphSpCfJwrGIAdVNxh
         M/mMe7zrpeNsYTIEWVFDhZV7cbyEubS5o3w2eVJtZqE7mx418RnQ4iM6ISSCS/kuLSOF
         46kKaa0y7aPuGr2Z+hKTFUsPMfUnJ/ExEEA2To5EFiLWP4cmmBfZHoBAd4GwEmi01yWJ
         /VgxkuRDVM6Exay9nBFPZ0ZaXZRuY6tiECz6+PxhEW5Z3FI4o7XELmc/YePjGgAE+7do
         MROUUjRrY903JuHAAIRW9Sb+bvW3QgUs/kYuNX/iteZeZjPPhKWqyN8TILlcEb+T3wrX
         gzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        fh=YGmwo52TIZlRKWKD7FuQ9B7w/+ywWPB3XRl51YlCOYc=;
        b=g0FoIJJk36ZZR+nyVtk1iq7HPJi4hYxq1NwtZCIfotZW0VQMR2kt+7gIb8Ot6SJjKh
         DcwCxurWo38hSrssc/mAXVTmD5EF+XEwq1TDu8avUWigpT9FQivAkvla8KquBYP6hwnV
         cy4yubaOcm8FKaliZM5/7lIzNBGXhjxbm5rqvTh/EOGOdRulHlLIK+IGpAZ5weom+QUN
         htEdywBKQJfkTOQYvV0d/Osp9HI6qOIShWT1i5JjhiB87s9+nW5N/I6SDYNeFAEnExhv
         BXSyLqrGA1tw/akhRBy/dvxqoMjzNevGD+HOd0ppnDBr5aVqTj6dSTgw9NyEuQRpr5oz
         GENg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774705207; x=1775310007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        b=CDEvyPuVDoJAurm6Ipy4sC0g77FY7WX7Hj7Y0GX3ZfTfB0oCEiNy0zPGyhMzkqDs2a
         YJebyPFJkM7dGctnxi8GJnbebKI4KfWZ9yJcGayBTdCyhq0KtiN64xSg5P6ckQhsaEeQ
         HOezVtlhhm0s76fO4C8aOGGWd4kSdN9wVLIioC0a3Jj3in+zrSOea2/MKnvk7ayend4M
         Fdjbykq/PnURVDnMC3nYSk6vwydevXT4bWizpwlqw31jKu9XY4TP9RLlo5312OxYQkgt
         +014sUSospkbg8lpNzwmFML32EFxCNKXMFy3cARWUNqbnqpW0qbMirq5Bddq6bNE7hEi
         RgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774705207; x=1775310007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        b=Is/jMaYDZr7K8ua9mR0X9k4a58lW3DRAw38hgzjNix/oHD9Gsqstfk9LM7rIa8QfxO
         uOMGfIOhFX5OLOr4g+pquQcTq/CLU50G0x0MagIWa3XFbPxzl5ZOo5FV7ZCxfMRxrPGA
         1Xrrd0jWmJyTpamWoMWKuxvMxJXOIClPGUXbol8rPhkHXqMzEaRdDlnsNxcBgt9adML6
         If3EhYxotZgSbpvfZU9vXktO2PwjRk8jLrOZHDmY2aHyMKub3fDCel2THy57rwr3TDXa
         MjRrCuLHPbTVLijIRkRmYUAuhZvDQZ77yL3usg3huk9Ms77Bbqo6XV4k/yNWvXfw+g9V
         nRVw==
X-Forwarded-Encrypted: i=1; AJvYcCW+icnXWtxikIOrL5RNwWUFCp9tbBEOa6f440JFwQ+c/PpqK629kWOliaJqv3AphHJkcfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ37K7kdEKyxjHb1UJ/SKc5+7+stGcdWlEzG+AEVYzBobDG2zZ
	vePv0GsDwe6jnnZXiWwgDLrR0xqU4hdR2jU+UjPqWTSntKBo2nr/U1RrC3dMBmrjods6eT8l8MX
	r0tM7I40m7xAk025Uk39CJYfZconPWh0=
X-Gm-Gg: ATEYQzwBCH5fW68U4zn60n5oG9zrWXsgsX+BaFvpTWv0vxvDdbR3W+sMe6wbLH8i+7H
	LuJ/Dnd9v9v09cdU/3TkqnUwS8p84TAOzaqZGqLKyR2i4hCZEF6jyfs4BZbb4B46V0Gq6VTK/UX
	2HPljW4pgKxdyx2hv93MDfXfLlF60+40j5VknkFBrMd6nXNkpbwz6OWNcxXCljACjQ2JmeVBnOu
	on00zhklZy06XWcBvXkmzjRoFhaMA0iDijtmB3h1LE1gc6Fs+yC3iWXLCxkmEfYiW59D+MaBykC
	niDcjyU=
X-Received: by 2002:a05:6a00:1789:b0:82a:6de8:fa50 with SMTP id
 d2e1a72fcca58-82c95e45d30mr6453604b3a.18.1774705207164; Sat, 28 Mar 2026
 06:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <91bacd7d-6ec0-4888-be0d-f11a6607f38f@acm.org>
In-Reply-To: <91bacd7d-6ec0-4888-be0d-f11a6607f38f@acm.org>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Sat, 28 Mar 2026 21:39:55 +0800
X-Gm-Features: AQROBzBTENtnZtQhxmzRNb76sGSIhzOCRnc5fvzKUgEMLoc4tyX_zU5SvhHxtug
Message-ID: <CAAWJmAZe+pyfju+37-dfjYUdwRR1ae6Rq8OJjZea76d2CPkEMA@mail.gmail.com>
Subject: Re: [RFC 0/2] block: Introduce a BPF-based I/O scheduler
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:48=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 3/27/26 4:47 AM, Chengkaitao wrote:
> > I have been working on adding a new BPF-based I/O scheduler. It has bot=
h
> > kernel and user-space parts. In kernel space, using per-ctx,
>
> Does "ctx" perhaps refer to struct blk_mq_hw_ctx? If so, please use the
> abbreviation "hctx" to prevent confusion with struct blk_mq_ctx (block
> layer software queue).

Here, ctx refers to struct blk_mq_ctx. The intent is: when no eBPF
policy is attached, the new I/O scheduler behaves like the none
scheduler; when an eBPF policy is attached, the blk_mq_ctx queues
maintained by the new I/O scheduler serve as backup and fallback
for the eBPF program.

> For what type of block devices is this new type of I/O scheduler
> intended? This new type of I/O scheduler is not appropriate for hard
> disks. To schedule I/O effectively for harddisks, an I/O scheduler must
> be aware of all pending I/O requests. This is why the mq-deadline I/O
> scheduler maintains a single list of requests across all hardware
> queues.

This new I/O scheduler targets mechanical hard disks. The scheduler
can be aware of all pending I/O requests, and users can maintain a
single list of requests in an eBPF program.

> Additionally, this new I/O scheduler is not appropriate for the fastest
> block devices. For very fast block devices, any I/O scheduler incurs a
> measurable overhead.

For the fastest block devices, avoiding extra scheduling policy is
often the best policy. In some customized workloads, however, extra
policy may be needed, for example priority scheduling, cgroup-aware
differentiation, or fine-grained metrics. Those scenarios have not
been validated with real demos yet, but the approach seems viable.

> > I implemented
> > a simple elevator that exposes a set of BPF hooks. The goal is to move =
the
> > policy side of I/O scheduling out of the kernel and into user space,
>
> What does "into user space" mean in this context? As you know BPF code
> runs in kernel context.

Sorry, my wording was inaccurate. It would be more appropriate to
phrase it as "into user-defined BPF programs".

--=20
Yours,
Chengkaitao
