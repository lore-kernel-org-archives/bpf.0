Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F842A15C
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305795; cv=pass; b=mzOxRKiUvR/hl+cgJz8jIEx4aBB04uSOvGkOBCwsO2eo9ftfdpsjHlaCL5NiqoWZuJQiIaxHaS+5jMu+6VBNwvq0oBD6QVV45JOhkMqTizkaN4m5yykW36aPpl+9n5mtheqTx7yXuBHeSXpaJEd+++83Xjlfrmp0O3zQaH0fPeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305795; c=relaxed/simple;
	bh=KEIvrRuiVrT7+dBXuaA0uQ4mV0n5hVwt+9ry5LaCeWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWhuWdBlss0WAnzugK0fjqQHexTLl1w83CZqi6blD/9CAwHDUpbkqOW5lpVq/Y7J0eUM/RQ3lydMt7R7lr5iIAAh3OGL81fll1u7fbgIOQbQKZAeGfZ6pBLd4/OLfasn9RDG1m7kBBRWk0UPVVV+6wWiTWCRpgx+K3fUsCNLeeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azzd97Uh; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azzd97Uh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so76125e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 09:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784305793; cv=none;
        d=google.com; s=arc-20260327;
        b=nq+R03kEgBtCC293muEFUYfWEoFr4AVQB01biNlOWv6ExXfAzsIYYL5mqIjFJMKzUs
         +sVOMmfBWhO/XOO3c2Hw2UC5/bc4eeOuwNZu9+7V7f8E8od9099gzE0aDuX/5eqTNoCN
         DQNV1fOchJ0I1y6qFLNZqueHnrLiRiS+eSoqopGu1hw5B0dFkF4Sr4/2FYGlLaiDnHFs
         wEeWmPg7pjkpqaZjgOsGgUH1jw3Jc5Vl7K9YLN3ON7bFAba39ZMh1Mmx0fNNN+rDNz+A
         uLbJejdnovHmtcPWC4j3oZX+uC9phwDebwsAFC+7TJQmm8D9rTgF3tCeT98SU5QITwFw
         Nr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        fh=bZHGP0q1Qy4CL6/Xb7Wxvp0NpTkNlhrZ9peI4Twk3TE=;
        b=dIAfP1+HfvdHH7ZJWS5FD4rV/2TmoYoRqrBb7oC3bKbYwwy7+YF1M0Wj0TMmZGJETw
         Z1/qyNIrob7OLMY45f9BwkBlsSvjtBmNLyPjNNS4Rb3GWf36pdEHAe7kId4jXlLYZAJO
         sxm2bL7fqT/qcz6XAKygTGJwcFfS8eHYULLI1tfG8xX8TwIme4ii7Gps2cJJ8Sr6Wffn
         honB7ES6Cxk1hhx450ajhLtlnofy8ZNCmS7OgQQQEyWw2S2eX2JrKUm5Fcoa+YCM6PEg
         cocuJUWQtMlE2PdyC03xdL909NeNcVWs2MSNUMCRqUIfbviOi6kKxMd47xn1nS5qWE3m
         rcfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784305793; x=1784910593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        b=azzd97UhRk4GDudHUsml6PbuUSQ/8qXtL/v+QsrQ8C+U+JGlD4zoZZ9/EfcXrgPJ3I
         Fs/TE80q6YhRcj3REYloQtH/mRXRX1ifItzF2Ge8OwuZyTti4F3CCDYVv92jhXvXrPhd
         48gLpFL9cxUn5jUtOk+0ocn3a66wjr5R3YcYdMPRaEyzAs2O3Yx5Kx90CuGaH00smq2f
         FaXDxS85tOUL8WuG3FFGeN3OvOl7g7mcBhzMDPSCMnAaEso9hb7vi/oqxx1GvtANZmJp
         rdAzN55SUo7rpwLMW1+L94jYxA+FR6URGmEwloPvZlJunWpdo4AMFpy5Omn8dv1CZQYz
         bZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305793; x=1784910593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        b=X9ssGLeb5ch4WH9Fq3lhrrY4+GAnrQyzu4E29TFLgB8Uhh0o1ZiFrK2Yc1kpwJp3fv
         kBjSrk4nJvo2Deuwi57oBoem2StwQ5QY1RE7LlX8UoXgnn/IAhQ4akliJG2YlyBsiTML
         74p1gW2x68oq0cwdScKYQftdI82Ui/gZ8Q3YNYYDkx46KXLNnIKWRrj1YsLiwu4oEvv+
         dc+Wn3e2Xhow6bJG1ntamsqshWEE5wvUGklPCDcSOV75qrsZgD0IBtBD+5EGky2C2rNK
         3eCQnVitWogIKGkQ07NKa7TISDu7cE6xJbLkB0aYb5qPkDhyXG2D04GGOi+IA3yhU0QF
         6TTA==
X-Forwarded-Encrypted: i=1; AHgh+RqBqBNTBstUNZAtp/x54mY4qb6LXl8PAkTgXZzY39+wFqy2eGKq8Dd7JJ5C34rzBeR2GaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TO8wVBuacRBXMakvBS3PYbdV6mIawwRLF7kAn/Lq1+cY3XT1
	V7dJdkbAOK15SOEcZKvnsa6h8pEgFmp++b5qFWApdVF9EMDcIcJ8dNN/y4UdkpVG716W5eWsLW8
	5i8cVkri58jnyiv3qTllixD44HLdtw7Evm6TnNwTg
X-Gm-Gg: AfdE7cmH/E+8DlyfQ3XlH08/o7wQ1QZAUBPnE/uf5/3KWBDS87Ruz/t8YymeeNbtv0l
	itSfftG/Imkvvm8er4DYeVFDR7G6oSy9QDRCjzlakj8HDVLTz7OAH6pIel1/c1nD3mXK3xhqb1R
	iPxl+ma20OiyTNNHTpfttMDcW/fdoZVUNN8BLgQNX5b7Tjaa4/4Na+4nFcmntt7k8D1hRtzZvUI
	nZSEblT8a6wGwsJECLi7xvBktjlRFQTNQI7AASpOM0BiGQy+I51/QWA4kz9ZPPnPlD3eD38ekod
	4Ju7R09EE/pxwgtct690gvYN/Lg=
X-Received: by 2002:a05:600c:41c5:b0:493:aed4:8d03 with SMTP id
 5b1f17b1804b1-4954f623a21mr164335e9.9.1784305792127; Fri, 17 Jul 2026
 09:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701192210.2997769-1-tjmercier@google.com> <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
In-Reply-To: <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 17 Jul 2026 09:29:40 -0700
X-Gm-Features: AUfX_mwkE9srLqf9jV3ClopD-np-tcerODpRpCcyM1eqJKlhjubKKS2HeTkHP3I
Message-ID: <CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
To: Shuah Khan <shuah@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 1:53=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Wed, Jul 01, 2026 at 12:22:08PM -0700, T.J. Mercier wrote:
> > Write permissions on the /dev/udmabuf device file are not required to
> > issue ioctls and allocate udmabufs. Applications should be opening this
> > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> >
> > Users are pointing to these selftests as examples of how use udmabuf,
> > and encountering permission errors on systems where write permissions
> > are not available on /dev/udmabuf. Apply the principle of least
> > privilege to selftests which use udmabuf by removing the write access
> > mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=3Dv7.1#n49
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
> >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/=
testing/selftests/drivers/dma-buf/udmabuf.c
> > index d78aec662586..ced0b95c876c 100644
> > --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > @@ -140,7 +140,7 @@ int main(int argc, char *argv[])
> >       ksft_print_header();
> >       ksft_set_plan(7);
> >
> > -     devfd =3D open("/dev/udmabuf", O_RDWR);
> > +     devfd =3D open("/dev/udmabuf", O_RDONLY);
> >       if (devfd < 0) {
> >               ksft_print_msg(
> >                       "%s: [skip,no-udmabuf: Unable to access DMA buffe=
r device file]\n",
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index e098d6534c3c..8114a29692fd 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t s=
ize)
> >
> >       ctx->size =3D size;
> >
> > -     ctx->devfd =3D open("/dev/udmabuf", O_RDWR);
> > +     ctx->devfd =3D open("/dev/udmabuf", O_RDONLY);
> >       if (ctx->devfd < 0) {
> >               pr_err("[skip,no-udmabuf: Unable to access DMA buffer dev=
ice file]");
> >               goto err_free_ctx;
> >
> > base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
> >
>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Thanks Bobby.

Shuah, would you mind picking this up?
