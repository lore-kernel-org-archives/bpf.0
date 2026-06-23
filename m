Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5461DD0D4
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184789; cv=pass; b=IX08H9+IHye5T+YEI9oOqHgZFj8IuKCbTTfEN0h/KCXJsj2MKUUrvdypw/b5kKXyss2DIX5R6+BdLtvOwi+XNZdLrrW6Mcs0WbdEc80G1c0u8N9sj3zF7ytC3Y8Qj9XSjdBsrzOlR3ThTQ6BBvvwhNQVrev7c8OnKsVPHrBz/X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184789; c=relaxed/simple;
	bh=sIVOcjT140xkpvRwGIeYXrMxj/eSYgFIXMfkLtskuUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNdVq0CUVgbP6V4HWlVtcV9IG2VNQprPOmviR0iflHqfUEDrHFADXp17PXwJWyb6JDWMqdmGlQHL1G+2KwcGQ2J7WSCzJ6lGaZt/xmh5zFp3Hj/8Oc2OzuKzG+IbJlvt9CdvXkxi7QV/ged5EOEwg1CKKUBxrOjb1dijaV/rY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCE+9AFc; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCE+9AFc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c890110acdaso2063841a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 20:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782184787; cv=none;
        d=google.com; s=arc-20240605;
        b=KztZ2nib6d6+Aoo0FmWi1C/xbFUbgGgCwfFxa2n64X8VBs2BOWNEvAotMlK3A6CN4/
         nhdlgPwHYMyRELGdXojQvoLtsLmJp8bS8OtSaMR5NLElIoSUqOfPFQGAUA6pHSzm6d4N
         ISArcxjVFjeMo6/+Jrl38t3RpCx7GyHAi4IGTLt+0dvzT5lRYbKH+MGCySLKD5F43yH0
         CpQP3EOG++LuZC85SWJ3da2jT7ByipsfyznB9zSL7Yky/xlmepVMZMhP8PfCrxtOQ7Xu
         GX5zgdnmSok7QCLp4JvdbMWwEwvexomHXyjSRrA7k+r4DovbB7G3yMx9sua6jHYXuVfw
         EhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0YM4STa5CSZfl8sa2TQS+jhPmvki32XUV7a7gLhpB8=;
        fh=6fcGoMU8zgDGuyXY9sUxMfTACU2Ul5WBbg6U3r/YvPY=;
        b=c5SwqKZbKHl6mL6Ef6noiC2PvjCvi0CYte6CERZ7tmzAkx7/AlfyG2BC7jeIUC5uOg
         TSAY0IflmTIVxxiw9AU/fVA5BJdT/13UyhcfoWI3bRvYdGGy+XHk2Yr0ID2PujLt0LFe
         7jWalKndkViRBzbAwOtJmulJ+famr4Q8dL+P9063uADZ7k/mbcYZf7i06U3eoa88PleB
         IM6lt3TfcD4o2FN8005AOgBtOYAOK2Nz7Ufz6wH+e6sAGL3oomrmjaFA6GcXrkG/RcXq
         nOXTYSj4l3u5ULVMXmz6BgZYa7QZWNjlguNt2n4mqODmCODc1KZYT1dTuSC/7Q88Qomp
         KtIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782184787; x=1782789587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0YM4STa5CSZfl8sa2TQS+jhPmvki32XUV7a7gLhpB8=;
        b=JCE+9AFc+78Pnz+KCkGLPsDbiel+QwHK8zfywCBse/C5BP36nRdMsx9mbY4NksL7Dm
         r+eqkVokmq7UQ/iQVeS2eQkytnf77h3Pf7Sr7s14h3y1gicqtnje9AVFQIqVebD5Nha7
         Adfiv1+Z4XniJnE4UHKgTFrmITFGGvW/W3+3dquH4pgNTxHiZ+AGp4rtHppiXuwPyNfj
         7iqQW2iiB33AJR0Mez2M2eCfefJIH4l9AT/OekozDGXnz5aIqoh5M4o2p578/BRNNg+R
         xlpZjzeEwCKft19rEDXB63TKVGQgP9kU2Hu+cSgnr+CpIB2ZMGB4BOEkBm0paDdvh3sR
         Czkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782184787; x=1782789587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0YM4STa5CSZfl8sa2TQS+jhPmvki32XUV7a7gLhpB8=;
        b=X3P5MblQoDzGxkGVHqyPSxqZSPN1OTevlbSCBflM80XCQM0bpl0UzOaaE43Z2K5GDm
         Uh9XMa2LKBj1MU8wa1z7VhbwQ0Y5kWe5UhVo6hmMBK4L8KOkraaEYHBbG0IAsGnw5jcs
         Lm2sCzFsAqi5eWd9hRVEPnECQKKDROiyHiajdvDOZUubn4uZ4SYkS1uOdXZgneVKPQJ5
         EGfUZzQVVSP6zZEuqvXDk7pDKS1v4ZDrgRAGxOy/7gdg6xlGS1jZSqaR+7ZXgycMOWOE
         RZHAQc0JvGuMpWsbUOgvpAvoGC741FEIiPK1FpExh5V9VmMDRc3aulv/0XiTkNuwOsPZ
         Vt6w==
X-Forwarded-Encrypted: i=1; AFNElJ+/bXKjhP118Jr3bEiQqC4gGi1ABOigqdOzxL+WJ2chAxcnIqF2749aIRULZenZcYEBllo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJ98ionELS6VfATr12vnv3sS3ytL7rx5Cwd17A/2F98ExrbLK
	gdtfST4p3lwAHpz9AJQbMUyUzuEZ40+ezCzh2iW16t3lhkE33dpg3eU/rwyfoacffA5Emr9ycpk
	aezcj3NZSWfS+1kVgsTc27bkrYoHAvoM=
X-Gm-Gg: AfdE7cmZrel2Hx5rc//WABvo3t86+I4nS36UhEiaYTymFSDNPeBi1xdSmJujfQXEcKd
	FD4hSrJ36rRnHsr4URc9YSPQP4y7/sv0xaQuoB1YsxyozCnuxJUWqR8hP5QYsZ8bwAcQsv+QrLC
	ghZXwfq1SKNNX7vq16ZlT03sK/JyXEAV6PBp46JvEaxRIa1XF4D7cSmdkLUT+ldJbpgFdImKQ1T
	rR/s+kVOzeTFf9iRK2Hx1Sj0Sws9lCO/JMzzI0BW6pkTqHxuujXTT15why2FZkUMbT4uAjuY3Lf
	mHOLYHDze9sEsQHpuKGlFZ2rwBYYWa5/NFYq2smGWpiKzAsEaKc8JoIEfBExjm5n5dblhDfTvOs
	6AXA1CrH9I6nxQQ==
X-Received: by 2002:a05:6a21:6915:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3bc531af581mr15521263637.25.1782184787384; Mon, 22 Jun 2026
 20:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623030803.44798-1-lange_tang@163.com>
In-Reply-To: <20260623030803.44798-1-lange_tang@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:19:34 -0700
X-Gm-Features: AVVi8CdAruZLPIMFu_h3yH8syznvXwZwTobkc-arx_UU6umzIYouwwshplDtSXQ
Message-ID: <CAADnVQJTXdNUsLxEHZPg9V356XfuqrSTwSE3W9EaOuMjMznMEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: add bpf_memcmp and bpf_strpbrk kfuncs
To: Longjun Tang <lange_tang@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	tanglongjun@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:08=E2=80=AFPM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> This series adds two new BPF kfuncs to kernel/bpf/helpers.c:
>
> - bpf_memcmp(): Binary memory comparison, unlike bpf_strcmp null
>   bytes do not terminate the comparison. Returns 0, -1, or 1 with
>   standard error codes (-EFAULT, -E2BIG, -ERANGE).
>
> - bpf_strpbrk(): Find the first occurrence of any character from an
>   accept set in a string. Complements the existing strspn/strcspn
>   kfuncs for string tokenization use cases.

The patch explains "what", but doesn't answer "why".
