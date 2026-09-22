Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5435F60A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043338; cv=none; b=OycRFsaNlQaicKHw+7jtnmPNcQjknKznJ++QhhKtCTjJYFN+buqTHQjdtJ58qmtfJ7fmJOZu29e7CKUYxOFPYp1SRlwHtUCsZCOfhqTQkViOhYPgrtChkUCDfHRyhjTOoAjd6BB1yZfD2poMtagg64rzcQv7Slebx6BglN10MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043338; c=relaxed/simple;
	bh=estz9036jhOCyptL6P7XbpDuYAT3nR4TDFVhFqpU4dk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VUExhEWAhMEtwDdCJfl8jNcjarUVLIyYKgKYma+vw1AzXbg+OXlWx5RXy8AtRlbhxSLrnQGo3/IoWjr5tmg2tLmZTj3mOUNZ6YKTvJh7trAdTtQcM0Qp8cnLcztcC3jpNDDaTy0fM0m6F/a+qpY1X1vsfmzsZAWzLG+TfTGLk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyvO99Ot; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyvO99Ot"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso14235365e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043335; x=1790648135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hxB3du36QEhM+5rIVLMv9L+rOeqXn1CgyNGA4L6zhYM=;
        b=FyvO99OtbhtCHiMy9FRpe/jYLeppGfAR74qSNENQPYpRi6JvVKLS81wUu4Z2YVicc0
         k2kQFNMhO5IlrNN/AvY61EgJ68DWWYfcZtUa0ejkUnpSriFwypAf6EHCQkiyxV+sJPr7
         XWrNhxX9Xiec5wtCOjPJbH7ZSbZlrps3vtehTliKvY9rl0vq+D15gqotpqzVeDGN857O
         x2g9+98hCemKo9z7FUxYF/URRNGmm0f+KcAnPlfOgJc7O7DfQW9rKEymPDF2hnc0kvma
         zlSP13TerQQ20ggK/FUlEscL5z+NRosivZmOw6TahxwuSCCO1EyTLj2EEWOVVsaElXDd
         xRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043335; x=1790648135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxB3du36QEhM+5rIVLMv9L+rOeqXn1CgyNGA4L6zhYM=;
        b=uUUvJcE1iIxwlOpW2X6+Wcwt6mdfXRc4FdQTgpvlcMJ5nKpw/qqG7yD7OfvxJ3HGCO
         5BXlHiLF7LUWC5uUAOsTuqMH8N4dsaAjto51kyspNzuBbyVrOJlX/XDowmTx9z3ZJ7y/
         s+K+Mrk7RZE7wEJHbtcRHxr0RPhagpRUmhkOkk6MWh3fQ/9KpT06bYpbi8syiLn8jrV0
         ClgAlOnDUXeVgxog8jAhMVgY/ECSZotVJr+wE/iElVsQVn0u2WPknEv7PLls9gphovHz
         IFFw3XWF3OesuWdgX6aPxkM4LGC94bh2PTj8FDWDcFu+/lf46PxTqQTAzUUbd/tfXEPR
         1Pcw==
X-Forwarded-Encrypted: i=1; AKwUvBz3kFzN3bJIY1MEsDrH73/ggeEARNU9Fn9KZ03pOa9BcHCDIvfy6ynGuppgBt6tDdzoILg=@vger.kernel.org
X-Gm-Message-State: AFuF++mok/Eq0OlPJFxlQElhgAt3jBq9NPTXndfkQstFTKNZWMYdovrm
	GZprcoJCX9luVKjsxCJpS3IQZTkSmWypsf4G9Zyz+yOSqya2EMGLvwl8
X-Gm-Gg: AYBFou20iwuGEVIvACTQ/sZyPd4DBVS/nRDHI/OP5jmx3U+8WDF1lgqgWoUCvrQ2tv4
	DaUwzCAHsjPhj8CDU1BHAINbtoslHFa/GozSM8k/HU8R0icS7qe5EsX7I6RGBVIDuNRNnPiih4u
	FCCaFhYrb4xaNqBPXgiPRvN93gLimWUuN4ymDqyb+tdl3LvDB5zPTtxeNMJie9qDqaJ7o4n3nRT
	EgSpHVp6FnIU0e/ZdzlmoVEsmUPpxjNBnHm5QiqlOcfyD1x4fiOyTDW+GvqxOa2KPeFSIGWk5UH
	8JkD7p1CIzJ1AE00OnmyGWjX2oIMCyouqz/+Yd+BaGgsThz6C9FKBffYgjoB1i5pzbzC73u3DnC
	v04ysy9H9IooGm4OvgsqQbdwtFdjG/ZNfzEpb2cYJcTZrmV6BC9ho9IPClRPngYlyCLtge9DVkI
	Wg8bBWyY+eM/PE4CDo6lnUoqBaFM6NBV4sLtrunRVmZTqu1dgapKvwXLlY/0wyWd29gUZtZMQUI
	B17hUoAoGCFkfITfcDCcY3NdAKL/ne/M6Fa5H+BCI/AWNvR47CJ0pL/BKSVOC2wYW/COUXrnuVb
	a59STXBZsApx8P4qLUmuXnyu2FwY1jWvhg==
X-Received: by 2002:a05:600c:a14:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49fc568f7a7mr165868005e9.10.1790043335375;
        Mon, 21 Sep 2026 19:15:35 -0700 (PDT)
Received: from localhost ([2a04:ee40:2228:a500:f8e2:3a74:69bf:2c6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc061fsm34968545e9.4.2026.09.21.19.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:15:34 +0200
Message-Id: <DLLHEJEV6BLC.11XRTTF4NRGBI@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their
 frame
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
 <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
In-Reply-To: <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>

On Tue Sep 22, 2026 at 3:55 AM CEST, Alexei Starovoitov wrote:
> On Mon, Sep 21, 2026 at 06:03 PM Ihor Solodrai <ihor.solodrai@linux.dev> =
wrote:
>
>> Neither has a local fix: both arguments point into a helper's own
>> frame, with nothing longer-lived to anchor them to.
>
> It's the same problem as a pointer to callee's stack.
> check_stack_write_fixed_off() deals with it like this:
>   if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
>           verbose(env, "cannot spill pointers to stack into stack frame o=
f the caller\n");
>           return -EINVAL;
>   }
> CONST_PTR_TO_DYNPTR wasn't spillable before 7.3, so nothing depends
> on parking it in the caller's frame. Reject it there too ?
> and then no need for REF_TYPE_FRAME complexity?

+1, will be much simpler fix.
