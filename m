Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225E4084E
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852529; cv=none; b=lsqILiIn0zBKpIAT1dsjoHTfv1fTmT2Z25f7ysrTywrxw1s8bhi67DXIk7xX4Y2byTRIRZ9uR0kixMF0wqDQKS2vMRFJ3TQ7OWLVqO/xyA+I0nYUpMvqJVjIgxMdQ8CLd9ijnILKyHCaYojCcWe7arNKJ6l4JniUUOwhsxWzYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852529; c=relaxed/simple;
	bh=KpF8FNrBtts6yWAvglhYg0A+alTXJA9xoi8NIIAhGb0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZrKBJZw+B/K3cIe+rgLE86vVVWVC8DjE98N6khYDMatMYRFVfrEwlrrCp6gct4osrlf2Ze1wGigUjx/l/DwZGTOSgjFoTwn+J//Cit09OguNGpjVIDJzUXg/258NPM00gFt5I7adJg5A2I9tkFw5J7AbdGoXPGMKCzPnEe4KFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVLUK0re; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVLUK0re"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56b92a8f222so925247a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710852510; x=1711457310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gHWhRcOwpiViANLuIdcNEj/YNGGopLMes8rqjOji+w=;
        b=kVLUK0recXIQz7Nm9FfkjjbLv8kESKM1GtKFe1YBR98xWbt7RQ0WPyPnMUd13L58iy
         iHECRdLlq8a0ia4iXcdSPkAWrNyQ+r16ItJmokgG9vnRq+XhjQZgqA9iJ9Zg5vMQIOul
         Tqvw69j8eLzE6CzjrWDnuSUohY2HsD0UM3VcJAAL753paYqZo//SDFbV11fao8rwtWPD
         21Zt1P0dK8Ld26el/VXPHzsxGnclIEthWVd4+3a0WXFqI/ENMt2tQYM1omgqCR3gC6Li
         1RmI1aTneJ2UaPYBLoOVBq+NIpm7jI3PvFK223zfG5mv/n02M/6VS9MZ/PaO1bK975zs
         YKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852510; x=1711457310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gHWhRcOwpiViANLuIdcNEj/YNGGopLMes8rqjOji+w=;
        b=qhqsc7uUJ6aLPHA2eHoRia9bQvzs5/gU8Nf1WjIrRihuqpopMdPz5+MW/p0oCW0T1P
         QBQ9Ob9ATkSlqV4Mgje8RwJpvX0eKO5f48DcQmZ2mLvr9InpZGTXYJ0fJpat2Cyuo1YK
         TpjCk8HZRKWfej151HAQZxeWHCswm1gO10BTOiOv0YmEP0sMt2ZH1KZGjeRUhNNEz7Xm
         9dXwzvsPj79pZXOWkP0qguzAkQqVtM61sRj0Mf7aqrbuCrf/+sG1OHz27U+KHBrDrFIz
         z94mTz9Q/zobifDB2yUwJLpseG8uolJ6yzt8DyVV+qzdqLLN5dj/ymy4vv7ux4sbtyG4
         DQow==
X-Forwarded-Encrypted: i=1; AJvYcCUDDpciC3SxvHWZFxsgSewqeNx6FpgIHtUTbE3nPzyOS0efZ3VTIFO3k3rklYglhozTkn+CgM8cyLah1xUnRnJwOKu+
X-Gm-Message-State: AOJu0Yw83mmL27U5JZD5fBWp7O80X0C2tSBUw7I+2YBA+ZNxUJFZFosH
	rzjcNi35kfE+pzdVV3UR5tcJfClf0FOO5GZvjGGvO99vJvuH7P/E
X-Google-Smtp-Source: AGHT+IH6HqK/3OtJIMoHzhl7z4D/JzWtA7zlD2svoHi4lNjDkAjN/bNCftFs0Y1TI/QMFjb6ioyVCw==
X-Received: by 2002:a17:906:5f8f:b0:a46:64e3:e284 with SMTP id a15-20020a1709065f8f00b00a4664e3e284mr9373759eju.74.1710852509544;
        Tue, 19 Mar 2024 05:48:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a465a012cf1sm6138294ejc.18.2024.03.19.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 05:48:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 13:48:27 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: support BPF cookie in raw
 tracepoint (raw_tp, tp_btf) programs
Message-ID: <ZfmJm21mKaJN4vyh@krava>
References: <20240318184037.3209242-1-andrii@kernel.org>
 <20240318184037.3209242-4-andrii@kernel.org>
 <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com>

On Tue, Mar 19, 2024 at 11:19:08AM +0200, Eduard Zingerman wrote:
> On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:
> 
> [...]
> 
> > @@ -2373,15 +2378,23 @@ static __always_inline
> >  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> >  {
> >  	struct bpf_prog *prog = link->link.prog;
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	struct bpf_trace_run_ctx run_ctx;
> 
> The struct bpf_trace_run_ctx has two fields: bpf_cookie, is_uprobe
> (there is also run_ctx but it's size is zero).
> The is_uprobe field is not set by the code below.
> Is it necessary to zero-init `run_ctx` variable?
> 

I think it's ok because the is_uprobe is used by kprobes/uprobes helpers
while here it's used for tp programs, so it won't be used

OTOH it might be cleaner to add special run ctx struct for tp programs,
(like bpf_tp_run_ctx) to avoid confusion.. but then we'd need new helper
version for bpf_get_attach_cookie.. perhaps just adding some explaining
comment will be fine

jirka
