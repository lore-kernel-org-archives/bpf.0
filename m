Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1DJgrOh"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4CE4
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:56:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3360ae1b937so2611404f8f.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374993; x=1702979793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Es8+sjsUejcWt6rcj4qNGSradE15d3xTBubw2UH8fEE=;
        b=P1DJgrOh07kivUW/Twc3nbfWDMcOuzy8RHdjO2hlvyNSUVtZboBcegeE7i/VKrgu5y
         lY/KmWQAJaWZcz6QXPYMKifS+hj6DZcGL4KsFwieJAMjN4ZxURFWdr6sjVJUM1JOv7BW
         M+/BJ0nSTND6XO/EeOyWa/fzvRMudrIgWO1U7z92q2c9VF4seEgNUBpzR0o69SNa2cIO
         5fpmqDmb2T8VC5OnRMhDZbzaj+HVK6XdXCyflE9U3Awfyua/E/m8Xo6gHnlHqrjTdUgl
         LkDlkcbsdCjK4y1rm8tZEwQg4Hd+ox2P+KRwDGlVzOGdoaAw4oLJDyFZ/nWGPfrf0ANI
         Wsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374993; x=1702979793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es8+sjsUejcWt6rcj4qNGSradE15d3xTBubw2UH8fEE=;
        b=J4A8UDOf40tGdUNreHBWZeF2vNX3yDFXM92JeSpVB9XTwidMO9s9mc/R/pWvld4ydc
         S0a1SYjQZocvlleaIdAQjiN9c2jQ/Nn5xNP0LeW2+7zfq9amxR5VPGNjtAihgUI9dnWr
         Lpv5YcQn/3nt2v1oJqCWw0+VEmRcTsNDcPJa6FI1N9cEsVjwxChzTOXFjcChhsSI+hz1
         ncAvt4LN5O+801gUEc1njGWjZZ1VjIb5gJQ6pWc77xOC5lV38VfUv46GRaBPLMlj8mJ3
         gKBjf7AxEgdRTHLYCMEbbWYCJ+zBHC+eBtMgkFbWsFfo2CmQ9P7phyAF22HFLOUQcbLE
         lTRg==
X-Gm-Message-State: AOJu0YxfPsF6uY8MGXR2VMOJ7xsTw05ntW1lbrmrWL4OSQN5TscIQbE6
	JmgP8klEosN0HSsVEZdFpc8=
X-Google-Smtp-Source: AGHT+IEldfjOu3dAf5frnb3FlaOWKGocIvsRvB5ldL1ouDuJloMBZ4jeAJ+Off+2NfaSTMcClOHW0A==
X-Received: by 2002:adf:e4c4:0:b0:336:1b08:be28 with SMTP id v4-20020adfe4c4000000b003361b08be28mr2360750wrm.61.1702374993020;
        Tue, 12 Dec 2023 01:56:33 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0033330846e76sm10463847wrx.86.2023.12.12.01.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:56:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 Dec 2023 10:56:31 +0100
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZXguT7cQF7d8RuSk@krava>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-2-9erthalion6@gmail.com>
 <ZXcA4KxoaDagJPjc@krava>
 <20231211184908.qhfdspfb77ttm2zw@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211184908.qhfdspfb77ttm2zw@erthalion.local>

On Mon, Dec 11, 2023 at 07:49:08PM +0100, Dmitry Dolgov wrote:
> > On Mon, Dec 11, 2023 at 01:30:24PM +0100, Jiri Olsa wrote:
> > > +	/* Bookkeeping for managing the prog attachment chain */
> > > +	if (tgt_prog &&
> > > +		prog->type == BPF_PROG_TYPE_TRACING &&
> > > +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > > +		prog->aux->attach_tracing_prog = true;
> >
> > wrong indentation in here, please check the if conditions around
> 
> I'm a bit confused here, why is the indentation here wrong? IIUC "if"
> predicates have to be aligned on the same column, with padding where
> needed. Or is it always necessary to expand the last tab with spaces?

I meant it should have looked something like this:

	if (tgt_prog &&
	    prog->type == BPF_PROG_TYPE_TRACING &&
	    tgt_prog->type == BPF_PROG_TYPE_TRACING)
		prog->aux->attach_tracing_prog = true;

jirka
