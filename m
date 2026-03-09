Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935F30EF69
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079381; cv=pass; b=NoDd/oFcJPnouixPbeB8kaxU1JGzclo0K70KNB47zZ0aRfnMZEuDCL4kKGFbvE8Ohl6SismQKll+Tae/MH/xCSLTmyoZSDHRrLlxBiUinlpii5CSEyzUPxaYXH4+mypJQzJbQkwam3QTPrR8Ws7aTpoRNHf0Mob9KZRDgmokolM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079381; c=relaxed/simple;
	bh=WIqu7mUkCJ6Lg10yfVcb5jYNq8AY/flQio55MfHvbJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf3qOE8DxN4UGJ6j9U2+etxbh8ZDS3tcYElU3hro+ChRjcgKxBAWFkl7kf9ska8mkda77K3VkPGHQVb/MurHN1qrNQkxGLiGxUmsnTgckYcUSi1VmmsQyBbL3AHkb30ecyqp8igh1/gsbtem9FC18Rv2imNnMNM4ZTBIsgKaji4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZsVZg5d; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZsVZg5d"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so3593343a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079378; cv=none;
        d=google.com; s=arc-20240605;
        b=bakhZfPAsZj3+WDUp+ni0COHt2lSOb+MniJ9ZRccSiqn3IatP5HoP0zZmGO4qOKfcI
         s4+miSTQMAhYOfNz0azunujTCya/+sh/M2I9B0T5H1ubwFgZoWoAYPE89vl0MQA9M+IU
         EbRkTpMNmwdxHArNFBxCsI7E1zlY4sD1H9cL+GdHHWcxQP+ktQBs8BG/vc8W+BujuxAl
         MbQFhUvBCXABYGqui8H6oPUaVksk4YiSZSeb4QU+IQmSGou6CLW7x8ti/nwlFob6bwE6
         pPCtC9zHcLbmMqYxr2NmAKU5ragcVxkxbiUS7VS5nWKqqvbaqpnQce5ZOv/5FtUPmXdO
         GVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OSg0fW3Ve1hhz/sAyuUfKjxljNS+yaVJpNpH0is5qzE=;
        fh=8DoVh3Iyt0R+s2t7XOny+wXcz6YPk7eroGHcz2JdAg4=;
        b=kEtWMloxSsERaYC3jC7OUUebRPVR+vFkScGNgkDf0Mo6Td3DyhSEifOwvpW+5VPijW
         WMmqHrdlyLFmJdBdbG1T8UtZH8y7M5VE3LYbPZw5vKGOmRf1sfejN423mhjWH2rtlCpX
         xfQ3fitsRdT6/gJOiY/Kyf/s5MTQTknTVhc3BVGqnfbzNjYnG6PAbg5AbCiLtkPiOzTn
         FYmtWps4vqq7Asm5IphFu6quB5H/mE+X8UbyFYIIdiP1tubmlcMqzaw9yM16m8x6cOu/
         KB8k97z9pv2huwDa4bYxPo76t5Se0z2PsYNZpOXWRv553hxNzRpXN+ezhcjkiYW/2Uyt
         UFXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773079378; x=1773684178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSg0fW3Ve1hhz/sAyuUfKjxljNS+yaVJpNpH0is5qzE=;
        b=XZsVZg5dKBPI5Iz0KIUx0hRjHgFjC4GVJUPwuOEyu3QKP3SX/K4009Fmx7GxTl4GXT
         odX+uECvZqOjLczGM6/UT9dQLhSIUB5MIRjoPAsaHj6tXNMc8+4oL8fLkDxQdoTiSFrY
         s0Q8nIjGnq52tnawlKlVxQQQDAFbX2Yw+TpiGimcLV1CMszGq84nXYBYEWVUZq7HjWl6
         10Th2moD7zXlb0J88vB6360Wi3VQUXp5H70I27UGeNv6EFl82X8LDKp9Hf3sa7Ig+cz6
         rpWcHHePlQNSxKgg0BlGjdqNfG1rcmBcpRJk5uvaasuIK1YB23w/T7CYHdyrT6A0a3Fh
         rvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079378; x=1773684178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSg0fW3Ve1hhz/sAyuUfKjxljNS+yaVJpNpH0is5qzE=;
        b=YOL6kvDin4jstHj9L+eYLYbpzaIfXiY4DJahNTfoehwVPo6wTCZ56wnDYKyq89D+ez
         7ygU6C5sqqLnbB+jcRifbEIH1uh5wfG3Oada2P2/wSDXYSHsTw9tieaxegxoaDsUu/Ji
         FAHaQgb6GLGFIm72SoiBhzQoqmJWaK/i6NEipHxKCRJch8OHTehuxtuCvuFjiZoL2NEM
         0HG+gXHkV6Gek4QM8oM+COpwHhH3nvVyO3HhCNi0t9k18pG2xuvWXGscSDBqmcJPvUEJ
         gLF7MfjtwrC1innKP0xodi9irtd57LOyQrXU1A+ha2vYmqk4uDV1JpnryUhzkJName8v
         0mag==
X-Gm-Message-State: AOJu0YxqqGqzYVasFpeIwNCJz80XZ4kD54r6+ar6dhgp8Z8zKVTHkZgy
	dzGJFzwCHLEKdCb5++uhPvbFaD8BrttGb0Y/w0w6NaW+kkCOXJOgJCfzcLxVN725B0ZSMRWxnX7
	zYcLzhhT+moMdWMulDQiSpfe3cPmENMA=
X-Gm-Gg: ATEYQzz+nuOWFd9Qqa7zvxTST7n8F7gFxO26Hn9YaWl2LnuQO64NGLKvP7q0lV35Vlf
	APNcWYc7EwSw9D1Vb9JMOaMZ1YTv/qgBnQO/kyKzYq4h10J2g/cfOn/LW0hH8bVA5iEVMdQI6NF
	QR7bc+sxF5SW4fjOVQq9895C2mVH9uK79aXx5Av7uBIHmhTPFxtMpWTuOVxEJCTBW7JvLMB+/44
	AEqDa9i2IdvyfPAeXi1BK74e6gEoZ23AnOsCyDJu2CMZQl5K5QGiiSOIymbkVGrNUMwVa5ocRCx
	h7oFMpmR/02fEdf8/Tk7EEo=
X-Received: by 2002:a05:6402:f0a:b0:65f:76de:7209 with SMTP id
 4fb4d7f45d1cf-6619d4f1207mr4315485a12.15.1773079378107; Mon, 09 Mar 2026
 11:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-3-puranjay@kernel.org>
 <CAADnVQ+2FoGYUapuXQUcCEerjfxqFSSUc8vwg4q8TN0GVwaS=g@mail.gmail.com>
In-Reply-To: <CAADnVQ+2FoGYUapuXQUcCEerjfxqFSSUc8vwg4q8TN0GVwaS=g@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 9 Mar 2026 18:02:46 +0000
X-Gm-Features: AaiRm52O-Er5lmp9KGlG7Xp7sPRiqijXsGJ0P-LvZ2AEAptNpyNceJU0lufNnhM
Message-ID: <CANk7y0iD2hsfcYZ4eBHib0au_sZx_ziqXPR9cf7iAmqC73NgyQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 4:48=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > The open-coded task_vma iterator reads task->mm and acquires
> > mmap_read_trylock() but never calls mmget(). The mm can reach
> > mm_users =3D=3D 0 if the task exits while the iterator holds the lock.
> >
> > Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
> > on error paths via mmput_async(), which is safe from process context.
> > From hardirq/NMI context mmput_async() can re-enter __queue_work() and
>
> hardirq can reenter __queue_work() ?

No.

I blindly copied from defer_timer_wq_op(), sorry for that, I should
have thought more and looked at the lockdep_assert_irqs_disabled() in
__queue_work() which means hardirq can't re enter.
We only need to check !irqs_disabled() here as reentry can happen only
from bpf programs attached to tracepoints in the call chain of
__queue_work().

> Did _you_ think about it or AI told you?
>
> > +       if (!in_hardirq() && !irqs_disabled()) {
> > +               mmput_async(mm);
>
> Don't respin without answering the above.
