Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC83A254A
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331974; cv=none; b=NOinMFa6sQn6G0WBAJv9EvnwIpBHG7L2jjT5stKclJeHnWmI2yuLNQFPwHPuIUZKKQOovwmUu3/eTRBG4t6VbCpiA9F3Sl3QeAPfwTXVXabrtZop9HUK9KBZMCuOMwGu91mktwYnlqCjUJFtTq/1PBnzgkoU4ZpYNPT4H6KqLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331974; c=relaxed/simple;
	bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLhd29PSdo7C2tvA3mDqNK4uAwRq+wMxYCgJZkyBkc72bIaT45gkYFLLEVGh2IJsOxy0/w32qdLx309GbujHzdhmbXhGzBCbAt0o5bPQqyZ8uI37fi45lrMW1d1L+t1qdWQc6qvexhZJmN4gN8al3Dbq/BD9rgGH8VtCuOdYXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSp1vqO/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCDAjlz4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSp1vqO/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCDAjlz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788331956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
	b=MSp1vqO/ZibK6ld1XBbb8ArbgUqz+TbkLcPvPYSRHtg/ocjYynHE5nOX0RvJCTLiezpzkU
	q0qtsUSA88RqKwQuKNh+jkAihf6ZPrmXeWlrG2xwErI+CX/+8IJnWcBVQzFvZ8T3AKZJVB
	wD//rJyXO+MD5NduFpHzRkGkVgQMVEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-OrnR070TOaeH4VYOvUoegQ-1; Wed, 02 Sept 2026 02:52:35 -0400
X-MC-Unique: OrnR070TOaeH4VYOvUoegQ-1
X-Mimecast-MFC-AGG-ID: OrnR070TOaeH4VYOvUoegQ_1788331954
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994aebe932so6433475e9.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788331954; x=1788936754; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
        b=aCDAjlz4ftZsvneFN34rA4lQUiKWl2z3xolxh3a9cjT4knGEHvAGMslDaPcbTTdBpB
         MWzwLFGBXodqAXwS/mQszHCw/lQNCL3mitv4vOS9UVrarsHFWfCcGAsums1URKuNP9LQ
         Hk4nr4UrgCN+dQJx2CQ7HxJD9pvTx48cTP4NwevJZlG2ttfqJdl6E+rB2UGRIT/fsGAy
         yYVOb7EzMnyw7wkdL16ZRxF/VwndqiCW4k55lnegblI7Wqy/Bl731UPYXp8XlOq/JlX0
         4SXJmbQuRoavivLkzIYZ44hULkyXFbR0uveEYhuv3gQZHiFf+2pzwuvLLw1ZnP+90vgH
         /C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331954; x=1788936754;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
        b=O+iG2QUjS/IC2a1jHVsjxfMG1Jb3KUL73va4tzyvd+Pae8hiUSXdiUKT5crKVjdUHH
         oErl2ovoxme/Euf34qfNOpfIlzlJOZsOPD5dzlNg3IjpbZcBm9h5x6fma9+5KS4KVOQ+
         ZP41SONQINklz6sw12c2enjNQ6E0lcIUnYy/xYlDMjEz2q2fmOesdxKa0xsOZWfktXp0
         cSiJKp6qNBPJf3jwh4Ps7pf8mU0Zs5/1xOK7vGtK47eEnkUQv1sHVLV6zfc5X+Ai0Joy
         VKONYlpuXmxb/SET2QFxoSC7S9DaNmZgn93Cql5mEUyXel3qoppV32WFOUcArXJp6IpW
         5zWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqL0+aDAqXYpE5q1C3t1UHhRyxXL8lgVh2tMCqd5LrYASgJ0EFKk2YDckx7oG6Mv14wsQI=@vger.kernel.org
X-Gm-Message-State: AFuF++kK/JAWfLTVggN/1URQHf65Zn9nn3UlmMoGJhSdsCOo55paVkmm
	kPk9fYU0WMAHLp8P7FaN6FlapUUltOB8LVkzLBlRN+TloXSUf4RTgkZ9RH/8AtBC0lf/axis9Wn
	klOKWtu9ro0zaDOJ4lR1lky3W8TqklRfKL0RdZHht0sMXIAF7+ky1HQ==
X-Gm-Gg: AR+sD11tf3fI55u25ttXmWwJbCctzsD0iA+D4NWyO8ZfQtbSiQHxcKAcIk/qHW2kG2x
	9jT799JGFnY7ODMr4WPq22ThxKokScZTH0EC2VB9xYkcj7HTnp2qU0y4sGg7KJzabw2/PXk2MrI
	r8vYq8FNGGpKTTy+AZ8l9/5ha+27JYm+r0bH4nU29pFEMLLNABVHpxXTBkAnFWGIRcnrkt9t6eE
	HznXX3zvIQEJIYkT7S2WkcwJMeaN644Xa8Uy+uQNmg+Y0MFu1oL3JQxGcGE7Vja5YgkymmRCQ2s
	xhbIGtHMXPHPHhT5D0WD1P5IEhaVOZg121f4p8WpK0rWfv/1MKW9hGTZ5DmnsR5F+1MDdDcOxNh
	OpLhXfm2ViJaisAREjb4UKIyfsBZGSQ==
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr42599075e9.16.1788331953839;
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr42598525e9.16.1788331953447;
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4642382sm47964965e9.3.2026.09.01.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
Message-ID: <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Wed, 02 Sep 2026 08:52:31 +0200
In-Reply-To: <87se3sakgi.fsf@yellow.woof>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 20:35 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Extend the rv userspace tool to load BPF monitors, those can be found i=
n
> > specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
> > object files including BTF data.
> >=20
> > This type of BPF monitors can be generated from rvgen using the -b flag
> > just like in-kernel monitors and, after manual adaptation, can be built
> > and run transparently by the rv userspace tool.
>=20
> I am not familiar with BPF. What is the benefit of BPF monitors,
> compared to the existing DA monitors?

I should definitely have included it in the cover letter.. I'm writing it
everywhere (will present at LPC) but forgot it here.

Essentially BPF monitors can be pluggable, folks writing their own monitors
won't need to submit a patch or maintain a separate tree, which is useful f=
or
domain-specific models.
By being pluggable you also don't need to reboot to use a new/updated monit=
or.

Think of being able to distribute a more granular set of rules for RTapp, I
remember we had conversation along those lines, not all rules apply to all
contexts and what you send upstream has to be general, what you keep for
yourself doesn't.

Having monitors in BPF brings also other perks over kernel modules: a whole
bunch of readily available probe types (uprobes, fprobes, all unexported
tracepoints that are cumbersome for modules), the map infrastructure for
allocation is arguably easier and the code is verified when loaded against
common issues (NULL pointer access, unbound loops, etc.).

That said, I try to mimic as much as possible the in-kernel functionality, =
but
some things are not the same (event/error tracepoints).

These support DA only because BPF loading needs a userspace component and t=
he RV
tool doesn't support LTL and HA yet, there shouldn't be any technical reaso=
n not
to extend to those in the future.

Gabriele

