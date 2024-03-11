Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09FF56B6C
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188745; cv=none; b=JzmW17iJUEFxijvEv2tlNiccIuzmecGKo++ti6o9X9/MpN20rkvVdyMnDFTyJpEMA5UchfqN972z/LuKfM0B8TDBDYXSMINKtMbg6T0erqdapzgmQPu/hQsz+Xsxp4AfPzEyDkwc3MvAMean2xg5CQ8t/1CvyOIcFtaYVjT/rSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188745; c=relaxed/simple;
	bh=UxnbAUSo+88lJQ+P6Sfv/W5dV/HCtXbh5r5tC2bZbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGiRSSv4GDUCN2K74AFQ+2idre+t6viQoCuFh+JxKfOGLrQiXEr0DY+Z2p3PmdlfSk+/pP9Rhy4H9Jo3kgPpVEQIv6r0/D4Vd+6aMEHtFbwJtmQ4budrI9cTBVKZNRpoAKlkxM4Pqc1FYL5h7vGcXfqC2VDNvUWxnZi68Xu+OBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LkgBhHkv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LkgBhHkv"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DA6341141
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710188735;
	bh=o9YLDdfCdflFyCMs5+/nFPe6338k23U+/2LO3IYQYLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=LkgBhHkvWvV52s3wOJqvfPlEdLQtKt6w0YIqS0/AIHS0+t/QBUKGi3cT+UVWY9NJY
	 z8jxEsFZ7zhBrrrSlWIBzdLWDI8xQi7Bce4yyi5eIpdBKbHe4xUVRJisNs9HXXGVXm
	 jeo4UHI/HQIn6SyvXAz7AdHnawAKUuwJ3CZ84xCFrHAd5xw4WM8NNXLwTDDFZgWlos
	 lJzRrHgu2hTULTCU/phC6+rifsIieXof6sgLCr6T7e0WfsBcyP9/jaYDVBeZgWbjiK
	 l0FGMRZv2Mrh956dB6e4nzg28TYjDNecxf5iIBLdcq1F4YLx9F0q5t+8RTq9dAj+YC
	 yzTQJc2xRraPA==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5684b85e0c9so2193935a12.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 13:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710188734; x=1710793534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9YLDdfCdflFyCMs5+/nFPe6338k23U+/2LO3IYQYLE=;
        b=Vyn3CS3KadMR/Xdj3pOrwONQhl+0whA3bP6JyQJWkWxTo/UGRqGXHvRvbYt22XyHFD
         0T40CzG1F2KJ1fip9hU9P4XUOHBxFxYquEYXFShMBiwCRzhfr1xszHWDxk7FEkuWeWTd
         LsBJlltbPPO1AUvCQTfWnJAnsIOPPlCZ0YsylIEIOo2ko2zfvu1nBk6UJjfje0TS2WDj
         FaUJq1+TgZGgZPhZGFrvxOOo371l8xBfyzyevquM66YQ6g2l5JNtMHVY7jvupRfTayee
         IYGgLVMMTP4jxwnCoPOniNgnOshiGzbo1kfbuEoRAwVHaagVKwGrYDkaUEzZL3y6/QHm
         /Rwg==
X-Forwarded-Encrypted: i=1; AJvYcCXeTRUk3QWk0ghztlqAJzN2J4w3MlrAwfeRcaxS9emEsS7HjRLenX7j+OcBa8niX5sUbyYwiAw9sMExjw5/zwcFyYzr
X-Gm-Message-State: AOJu0YyvkosGq89BjuQhv3uSQvQuvnofmb4ecHO75y1QJJqOPQcHXN8C
	9N0YYeT//EncVxpOP9lj3np8d2kWWVRArtD/I0OcVh+VwX2YxA5TnexZEzD2bL2uejEaO1cpueA
	GMD0j/GQYujpAXHplyVFJDp+xMRytlmzvx0g02+Isxe18gyq3dZLJV/wFCxY4sa48RQ==
X-Received: by 2002:a50:875e:0:b0:566:6a9d:6147 with SMTP id 30-20020a50875e000000b005666a9d6147mr8824844edv.0.1710188733937;
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRSBKB/l5WrY2+SCwqGjztOQYnHF/v6oCAuorX/wc86bW0V0ykSX2IazmuHEnnDeQZHtJVA==
X-Received: by 2002:a50:875e:0:b0:566:6a9d:6147 with SMTP id 30-20020a50875e000000b005666a9d6147mr8824824edv.0.1710188733443;
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
Received: from localhost (host-87-21-72-46.retail.telecomitalia.it. [87.21.72.46])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7dc14000000b005684fa1c4dbsm2138489edu.52.2024.03.11.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 21:25:31 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: ringbuf: allow to partially consume items
Message-ID: <Ze9ou-OrYO8NZsDb@gpd>
References: <20240310154726.734289-1-andrea.righi@canonical.com>
 <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com>

On Mon, Mar 11, 2024 at 10:55:57AM -0700, Andrii Nakryiko wrote:
> On Sun, Mar 10, 2024 at 8:47 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Instead of always consuming all items from a ring buffer in a greedy
> > way, allow to stop when the callback returns a value > 0.
> >
> > This allows to distinguish between an error condition and an intentional
> > stop condition by returning a non-negative non-zero value from the ring
> > buffer callback.
> >
> > This can be useful, for example, to consume just a single item from the
> > ring buffer.
> >
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index aacb64278a01..dd8908eb3204 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
> >                                         return err;
> >                                 }
> >                                 cnt++;
> > +                               if (err > 0) {
> 
> So libbpf already stops at any err < 0 (and sets correct consumer
> pos). So you could already get desired behavior by just returning your
> own error code. If you need count, you'd have to count it yourself
> through custom context, that's a bit of inconvenience.

Yep, that's exactly what I'm doing right now.

To give more context, here's the code:
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

> 
> But on the other hand, currently if user callback returns anything > 0
> they keep going and that return value is ignored. Your change will
> break any such user pretty badly. So I'm a bit hesitant to do this.

So, returning a value > 0 should have the same behavior as returning 0?
Why any user callback would return > 0 then?

> 
> Is there any reason you can't just return error code (libbpf doesn't
> do anything with it, just passes it back, so it might as well be
> `-cnt`, if you need that).

Sure, I can keep using my special error code to stop. It won't be a
problem for my particular use case.

Actually, one thing that it would be nice to have is a way to consume up
to a certain amount of items, let's say I need to copy multiple items
from the ring buffer to a limited user buffer. But that would require a
new API I guess, in order to pass the max counter... right?

Thanks,
-Andrea

> 
> pw-bot: cr
> 
> > +                                       /* update consumer pos and return the
> > +                                        * total amount of items consumed.
> > +                                        */
> > +                                       smp_store_release(r->consumer_pos,
> > +                                                         cons_pos);
> > +                                       goto done;
> > +                               }
> >                         }
> >
> >                         smp_store_release(r->consumer_pos, cons_pos);
> > --
> > 2.43.0
> >
> >
