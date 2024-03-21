Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476874D9E7
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004543; cv=none; b=JokGMHq13cCE+wJ1LU7QOii1IOaBcKPqiTZqNww4rhHlEd5si9EXP4m7H8QOqbQMvPz2wMP6RNTbYhJu4ODzLI6yskcDuyVfqf0CWLbuYfoEExrWXfI6myUgI8A9IiA++RLg2pksgJ3S9ViKlsfRhRmS/UkmSYyjEKzU9I3rBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004543; c=relaxed/simple;
	bh=3Tg3nvczRcMbIHLoBuMi0VnOOseMcR7L6PkdqjuXvQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU9XFsZTWLJ8I+VW2Bn6ldbjIUe88AfyQlTubtvQYhevfIVXaQJKEnDal5IZ0SE4ZnUQKI4vL7YLl+8XBMMyeAM+TssWIZk6y0LveYhNysc4ODO1qTMqDy+9XANaEcyhqaJutri8XeEbltxrzHSv9tqHHWbM7qlVySlqBjDBh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kATpg5YF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kATpg5YF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341730bfc46so388013f8f.3
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711004540; x=1711609340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ12PEh12kME2wneI5oeOYqGQ6vqajZ7VWborNfH8go=;
        b=kATpg5YFEfjQjxDX2w2YCLYffqGiE/U2PyDAg/2SuATDKKQl32fYklQPC8QtBSAgJi
         9sl3V+FQi/AyZBe2Bhug1WhBNx6aZaNvSTSPLPrYHqO9SQK8KdhnQJd42VGcE5948ho9
         NisWsC8Gn7CksMX+3iAwz5/9Pg6xCufiBEnn/JMjhc+4rLcPqTpokFfgKySHlqE1Z9cH
         O8yvP55fUmMBf9aRePpMoe5J2fKC+35frLtQfGMxH4oe8rkNqplfGKvYu8Wv1+4awKVc
         g3cC59/s4PecJivjwiS1CGH5IYDoE862GpXDygfBSP5sZyLjPdHT7amBtiUrXxdKgLz/
         uM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004540; x=1711609340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ12PEh12kME2wneI5oeOYqGQ6vqajZ7VWborNfH8go=;
        b=WT7Gl5EBiLJlzQLnbQCttlyUEunTFvgCeBZ+Qw/EkFxrc0NUVi9lQ/ichMF88mpIEh
         Bqj+5KKPkVXt/LG3u89HNyUW741QFm4AE7rA/4Kv9iDqgEc1BKauazkKvq8bEYSxUWhn
         hoOhM4sdqsdLKed3LeKs29CZNj5rSyHKFDY2PbeD21Mbuhabm6EBnoNzkaMGZVA81fbt
         7uOcYMMLf6L/wzHFGle7I/YFUxk2qd7FbCsiJItGLqq10m31FKxYpMnlt8n7BZqhG8cM
         Y7NX5RfC7IJFHtSQdru1mk9RRU4VXJgs0cUPLG77PIut0qXG1WFMmui1O3PmoqvRseUY
         USvw==
X-Gm-Message-State: AOJu0YxnzKPQh3l4Ic70Xt/XmyKlhPrd1aT9+gi92xjx7EucplIKkghK
	BZBl5EPhtK0pz3+jswVq+HLo3fjOSxHYmiI6gbkCbzbASafPlF4IKIVnM1eXtLPKpLq10AvwOz0
	wmpoJ8xwYIz8QJpreotci/BXlx4RCeLdLtNiejQ==
X-Google-Smtp-Source: AGHT+IGAMaH/NjzucgH/qXZcLGhlj5Xee5rSKPj6wSv5Lafg5yxHByfF9mpItMnr2j29B3WHG+a9lrZj+7cF7KCIh2Y=
X-Received: by 2002:a5d:6da7:0:b0:341:a8c3:61c9 with SMTP id
 u7-20020a5d6da7000000b00341a8c361c9mr744022wrs.57.1711004540414; Thu, 21 Mar
 2024 00:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320200610.2556049-1-andrii@kernel.org> <CAADnVQK6v47nqE+0BGGFXFp+_5_Tbj23=H24yDJJo+MihQJYdg@mail.gmail.com>
In-Reply-To: <CAADnVQK6v47nqE+0BGGFXFp+_5_Tbj23=H24yDJJo+MihQJYdg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 00:02:09 -0700
Message-ID: <CAADnVQLCJRkBPejM3o_D5j6OjGmrqS53f_F5f3OsaykMJi+LFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: mark kprobe_multi_link_prog_run as always
 inlined function
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 20, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Dump of assembler code for function kprobe_multi_link_exit_handler:
> >    0xffffffff8122f1e0 <+0>:     add    $0xffffffffffffffc0,%rdi
> >    0xffffffff8122f1e4 <+4>:     mov    %rcx,%rdx
> >    0xffffffff8122f1e7 <+7>:     jmp    0xffffffff81230080 <kprobe_multi=
_link_prog_run>
> >
> > This means that when trying to capture LBR that traces all indirect bra=
nches
> > we are wasting an entry just to record that kprobe_multi_link_exit_hand=
ler
> > called/jumped into kprobe_multi_link_prog_run.
>
> I don't follow.
> If LBR was configured to trace indirect branches then this direct jmp
> shouldn't be recorded.
> If LBR is capturing stack frames (those should be call/ret instructions)
> then this jmp also won't be recorded.
> If LBR is actually capturing all indirect, direct and conditional
> jmps, and calls then saving an entry won't make a difference.
>
> Maybe it's an LBR configuration issue on the retsnoop side?

furthermore.
This 'jmp kprobe_multi_link_prog_run' is not any different than
"goto" in C code and other unconditional jmp-s within functions.
Something doesn't add up that this particular jmp stands out
from other similar jmps before and after. From cpu pov
the tail call jmp is the same as jmp within a function.
