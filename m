Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639884;
	b=vUxxCvW/9FTDDa1Von11uObS4EIYIG6eIX/0xawZEBox97+07soU6dQ4ebIEP5R4oJLv
	 iaqMki/avtORgzWLn9DRlEvFcmgTQJfCyG+VTXc4gRQdYW3+l3KlJF7Clt2m1sFHffbso
	 U7kYercLbElRM5snM1kws3aDiWHDbmsfdZMWfN1EcpBXjjsrNhFKlH/cSOUgtYOwjhgqT
	 XXG9MetXsPMhukQ1kIKg13Wpc5UuYey//x+Z657D89fvo8JNitk5Hc9fxx08Dqt95YXlH
	 YO+PHDnQ3E4BU6jys4FaWTrh8p9mCSw7traSeafFxlCVZxS+ellDrzMIMYt9degrv/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xDmehuoUlqwOcc/kOLT5AxLWBXn1crs/m+Pgf+b31Rc=;
	b=WdoGrn3u0FHtbIJ23C1ZYE1G8Hh0eVkCcjsyfYzv+qiT+BQVtIq/mSzDl/S0zms0uLMO
	 OzLOEW8s1RMfetPFGAJQQID8hcd6e1ejAVioAAt0IyUQlWOYMwoUPxtCjblYqfLvOwODV
	 2/a9prS6qJkVaFWQ/KfcnKwHDKitl4LlQBdkoUsqJ5/Dy8ly4now5pKQ6k4msHyWXKZHn
	 yHvCgEk0mXdqHN8lfl7DqhT1l8xYL8NU6IAFaMa2lkBfbZPi7gdxD2h3cJBMo2xYeftfJ
	 vU0XonZp6maAuAPYXXdnc5rLsWQuNidHR4G0imfCtyffTRnQ7e0sKQBSSWKutriWNvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RUFdD/VX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B4606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 152B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUFdD/VX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so3650518f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:51:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795639882; cv=none;
        d=google.com; s=arc-20260327;
        b=EsD0yAHPWQ75XoFcb24LWtvTw7L8ycC6CKupTGNx/bmq0KxD0ZwT9izua9ge2S+VLC
         cBcRTaqMD175bWROYhpYz+1VjlKZ8kWHVPvwQ+GgxQc9n7g8P28/IrjaBA+YvTC3nkcu
         G1U94MZhShocJWpzG4fNUhV54jt+bzjL2qB9LbDCM2UdxwNEkpehj97fMIRrSumzwD0X
         cEoedGadpEOB5HjI90E0B5b0lf4bg7uCYJzmuwXtXZCTVuFO6O4ShzEwD97qvxwLareE
         4oh7lPAiJciblZIxpjG2xw2HhdKxSdx5YfoCZEJt5z407mjrcIojRmPOcIrOZw6aGvB4
         V7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDmehuoUlqwOcc/kOLT5AxLWBXn1crs/m+Pgf+b31Rc=;
        fh=OD9HlkZPdWUmBu94gKiQEkulmJKUHioi4rqD9u/eNgI=;
        b=o/2gXI9esT8iwVv7q0DrJHnTHqnynTiIEAh31xL2H8Xi2EKV0YuhMOv5bhrs1B2ruH
         ilJLzjw56FxLdi0hjmeKnY+gmW+2MZpySyILO7PC5gKhIHyaE4WCPhWfm3VGwFbuDY0Q
         uATpGTA6qRTLEUxMPWEF3RSZwT2Q6k0y2VCBVj2LJKwpyu/yNsyRQ1z3N+QGeGg/fznZ
         GwDKppGd8BKhi4CcllY6ZJPFsbowVouALfLkP27TxmxMKPbU9Sqx4pyZ1DJ01La+L6y/
         OEbhUPwNvrCNftyLg5k8vtPkZBcbstoTXrUYsh9gxpaq6PaUAJk63tF7o+oBH6dFRJGV
         YA+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795639882; x=1796244682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDmehuoUlqwOcc/kOLT5AxLWBXn1crs/m+Pgf+b31Rc=;
        b=RUFdD/VXocTgF+Vg/eByX9wd2Cd37LCYfcUnBHlHJoDmkztyWNVAvcHe1+WzCmHwmy
         Z1F3rDx1V8aCriJMAgafESV5wm8XtqEKSCRbrlDAsrU1RQcyeCUoD8bvZ3JN1o2zCzF1
         jek2zn14NFLVSvMn1Bh5vMnHAB/xHpZgzOg8jBpGoy+JnNo8jJOHeMIMx9pgVF+r48zx
         O3vOWV/oTJKpRXPVzrF3LoP1hy8nU/yzazSvWlcRZAGosqpAsgk38Un9nlbTzuuDd9ka
         ePYVnkBSPnQMbn98igJ47AeuQt4PRDBTD31ClSY9ucCvFiXtzb3iLRKd0puj7VLEVIWm
         d3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795639882; x=1796244682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDmehuoUlqwOcc/kOLT5AxLWBXn1crs/m+Pgf+b31Rc=;
        b=JEz5PxRe3D6jjTWP13M9qi0UjkdHNMCxjueqh2P24wSymke7Y3SlRh2n0U7u7SBarF
         examLPflPO5kZn6sJ/VCzl9F2A5YKStxfKMDoH7NapleY3BOxcisxyzj5V7rYlyjJIUX
         OrWJzPecZR9A2uNmQiiCy2Y9d5AOYqlWecJDJD1o9qKR6yzlaCzrwelAMqH/b1Xf4MUw
         fgw9CQnOiv2ryx+FYbpLwkmV46f2UJGXCBbXk4COqQfw6Xa/o58y6MQyQ41zhV0l6DrN
         0XjGVmSo8gCCF1hlkTQbV/lHbsbp+0FRrYtwb5JZ8YBVAesJdT8ck0hrOGx2poYHhuVs
         4VnQ==
X-Gm-Message-State: APuU4Z8Ew2DEcCOp6LlZX9Q/N8jIEl3lVxn6QBybSPjzlgMOF38WTUZZ
	7fvHRu06+Qfs9Qw5mu2cy7G2LDW+jA17dRV8iKFc5a5KH6Ep+L1zYvABpbGjaI7DpgoAlBnxjpH
	jK1KH81rZX3e6GOvKHyAZ18kFyznE6z4=
X-Gm-Gg: AZFdTZfF5TIjrLnXkbUMRAjmKjwO+/b9ylxnWPiQecHcz5AlxManIA/5yU5y4MjgBm+
	aSBDyCN27ZLk8qoiVZZMTh1Uj90VtHfAN820XFikU0VxZBNzMoQy+VmUqD27Cs48MLKgm0Ew5KI
	luzj9Bo+3o40fH5D3NbO07rBDDnkCDhId4AJC68cQlqgF1DGjBvbHHcel7WYbAYobi2brOfrkQk
	l51jBEYPPd3uYaPVAb87lxq8lOMIYGeiHHenJVhlUjgiq79Ty5JjyDQQmOE7fxjvS6GZC4JRQjP
	keOj3UjAeOgPFaS2BNNsZ3luHfUyexljR4/HXcw+7RmBX0LLr0UmV9NNgoEtFHFJD0O6r3B4DiO
	5QAofDzHV+WBjB7o7aM+RtE3P2oOJYgx1JXIYAi+Ou4SB/1yOBsxiPrAVer6gE6IDGI/8iNz0Qo
	HktvuulqOvKUhcxV2TEXQ=
X-Received: by 2002:a05:6000:2309:b0:4a7:45a2:ec26 with SMTP id
 ffacd0b85a97d-4abb0f3bc89mr38860008f8f.16.1795639882315; Wed, 25 Nov 2026
 12:51:22 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795467315.git.memxor@gmail.com>
In-Reply-To: <cover.1795467315.git.memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:51:10 -0800
X-Gm-Features: Aa3M54r-cYDsiaAoz2Q5dgDNxohft3vUbhp6NUZX98MlTY77zQXZkGpWrikg4uo
Message-ID: <CAEf4Bza6XCG1dMTE3BJQxaeiV7xutcyY=fM_xhwMxcXW8-182A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/10] Ring Buffer Iterator API
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 1:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> libbpf can only consume a BPF ring buffer through a sample callback, e.g.
> from ring_buffer__poll() or ring__consume(). This series adds an API that
> returns records to the caller one by one instead.
>
> It is needed for overwritable ring buffers (BPF_F_RB_OVERWRITE). There, t=
he
> kernel doesn't wait for the consumer and overwrites the oldest records wh=
en
> the ring buffer is full, so a record can change while it is being read.
>
> libbpf rejects callbacks for such ring buffers since commit f756eedb24d4
> ("libbpf: Reject overwrite callback use"). v1 of the overwrite mode serie=
s
> copied the readable data before calling the callbacks [1], and Andrii
> asked for an iterator-style API instead [2].
>
> The API works for regular ring buffers too, e.g. to process a number of
> records before consuming them, or to consume a ring buffer from the
> application's own event loop without a ring_buffer manager.
>
> API
> =3D=3D=3D
>
>   struct ring_rec {
>         const void *data;
>         unsigned long pos;
>         __u32 len;
>   };
>
>   const struct ring_rec *ring__next(struct ring *r);
>   int ring__release(struct ring *r);
>   void ring__rewind(struct ring *r);
>   bool ring__invalidated(const struct ring *r);
>
>   struct ring *ring__new(int map_fd, const struct ring_opts *opts);
>   void ring__free(struct ring *r);
>
>   int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms);
>
> ring__next() returns the next record without consuming it, or NULL if
> there is nothing to consume. ring__release() consumes all records returne=
d
> since the last release or rewind. If it returns 1, the caller has to call
> ring__next() again instead of waiting. ring__rewind() goes back to the
> first record that was not released, so that ring__next() returns the same
> records again.
>
> ring__invalidated() is for overwritable ring buffers. It returns true if
> any of the records returned since the last release or rewind may have bee=
n
> overwritten. The caller has to copy record data first, and use the copy
> only if ring__invalidated() returns false afterwards.
>
> ring__new() and ring__free() create and free a ring without a ring_buffer
> manager. ring_buffer__wait() waits for data in the rings of a manager
> without consuming it, for rings with and without callbacks.
>
> ring__next(), ring__release(), ring__rewind() and ring__invalidated() can
> only be used on a ring without a sample callback.
>
> Usage
> =3D=3D=3D=3D=3D
>
> Wait with the ring_buffer manager:
>
>         rb =3D ring_buffer__new(map_fd, NULL, NULL, NULL);
>         r =3D ring_buffer__ring(rb, 0);
>
>         while (ring_buffer__wait(rb, -1) >=3D 0) {
>                 do {
>                         while ((rec =3D ring__next(r)))
>                                 handle(rec->data, rec->len);
>                 } while (ring__release(r) > 0);
>         }
>
> Wait in the application's event loop:
>
>         r =3D ring__new(map_fd, NULL);
>         epoll_ctl(epfd, EPOLL_CTL_ADD, ring__map_fd(r), &ev);
>         for (;;) {
>                 epoll_wait(epfd, &ev, 1, -1);
>                 do {
>                         while ((rec =3D ring__next(r)))
>                                 handle(rec->data, rec->len);
>                 } while (ring__release(r) > 0);
>         }
>
> Consume an overwritable ring buffer:
>
>         do {
>                 while ((rec =3D ring__next(r))) {
>                         memcpy(copy, rec->data, rec->len);
>                         if (ring__invalidated(r))
>                                 break;
>                         handle(copy, rec->len);
>                 }
>         } while (ring__release(r) > 0);
>
> Dump an overwritable ring buffer without consuming it:
>
>         n =3D 0;
>         while ((rec =3D ring__next(r))) {
>                 memcpy(copies[n], rec->data, rec->len);
>                 lens[n++] =3D rec->len;
>         }
>         if (!ring__invalidated(r))
>                 dump(copies, lens, n);
>         ring__rewind(r);
>
> Patches
> =3D=3D=3D=3D=3D=3D=3D
>
> Patches 1-2 are two kernel fixes for overwrite mode; they don't depend on
> the rest of the series. Patch 3 documents overwrite mode. Patches 4-9 are
> the libbpf changes and patch 10 adds the selftests.
>
>   [1] https://lore.kernel.org/bpf/20250804022101.2171981-3-xukuohai@huawe=
icloud.com/
>   [2] https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=3Du=
ByFSup31FMA7hw@mail.gmail.com/
>
> Kumar Kartikeya Dwivedi (10):
>   bpf: Order record data after the producer position in overwrite mode
>   bpf: Keep an overwritable ring buffer readable while it is overwritten
>   bpf, docs: Document the overwrite mode of BPF ring buffer
>   libbpf: Account for the overwrite position in ring__avail_data_size()
>   libbpf: Add a record API for consuming BPF ring buffers
>   libbpf: Add ring_buffer__wait()
>   libbpf: Support overwritable ring buffers in the record API
>   libbpf: Split ring setup out of ring_buffer__add()
>   libbpf: Add ring__new() and ring__free()
>   selftests/bpf: Add tests for the ring buffer record API
>
>  Documentation/bpf/ringbuf.rst                 |  44 +-
>  kernel/bpf/ringbuf.c                          |  24 +-
>  tools/lib/bpf/libbpf.h                        | 139 ++++-
>  tools/lib/bpf/libbpf.map                      |   7 +
>  tools/lib/bpf/ringbuf.c                       | 336 ++++++++--
>  .../selftests/bpf/prog_tests/ringbuf_iter.c   | 586 ++++++++++++++++++
>  .../selftests/bpf/progs/test_ringbuf_iter.c   |  66 ++
>  7 files changed, 1155 insertions(+), 47 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_iter.c
>
>
> base-commit: 2bf3351c5f894697e8443eeef5333d4c4ce90cab
> --
> 2.53.1-Meta
>
>

I like this, it overall looks great. Please address/reply to Tamir's
feedback, but I think this is really close.

re: code reuse aspect brought up by Tamir, though. If that ends up
with more convoluted code structure, I'd rather take a duplicated
implementation rather than contorted shared code implementation. So
please use your best judgement deciding where reuse makes sense.

Thanks!
