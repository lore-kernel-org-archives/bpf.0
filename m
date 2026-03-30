Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E038F957
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889139; cv=none; b=Ux5is+hNlMNQjTXAt6EraHDnORAT5j2fKuonu8i/bYNDgVZHWbLYcpmDKWDVHcMmkBySHZ69jtP+WQTc8oFySYeZoxZVkYOh5uCCIqOmyqoWyuY8gxO/aVz5q3k9ZY0MEYjFpmO3MUl/joOg8lsSoekW8KyRgYavAqduubqYAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889139; c=relaxed/simple;
	bh=IpNnA9s1KINuamNfFsS2gV/eEu/pI6jxdZ/6/nT+doI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwKoda7+HMPFFtZEp4HEzIAqez9wLVpjqGRnELDu4qphxnaGx6qjnbRczzzHpSVEnd5S+msMQ/nMJf+ITX9LM3H87yQPfJ7MLVhc+faCj+EuWSA/VvF8e2DOZCo8D7pQBBJRr6oXKmLzmE/i2FcaUATFixugBb4gAXATEr5LkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=LUUIu0Nn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="LUUIu0Nn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad4d639db3so21451855ad.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774889136; x=1775493936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwE++Vqw+CySglw+oPVi7SkePVFEszmRECwetM66l0k=;
        b=LUUIu0NnPlqE2N6oFk9t68bzUuF/WGQ46GYjp/96iytW8uH1U+ElD8HGdhBpUqHzE0
         SVYLQR3kd1yiH2vS3Jh1taoFYUI+Uv8HJ943nKTDUpfnWmCKW2OiSeibmIV9F8A7KbJB
         omg3/kOpSdBX4WPX/49q+PgCMvt4Est6ljAKXDT9735B6QsOl2LF5CSDYJCbnfejABs9
         ivPeE76fx3mRjix5/8nWUkjxqtDvjskmwxRh/W+TzR36ocXQLn/J+KiuirqFZRbGHJM8
         JqbL638lreTaVI0Tfua4xM+FzSqTJ4DNl742AiWzjqFAMG0J69j22DshZZe7iec8EKeN
         LZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889136; x=1775493936;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwE++Vqw+CySglw+oPVi7SkePVFEszmRECwetM66l0k=;
        b=IPvti2tt7YoLwNfE55EolOwiIleeL/Ms7vqd7VOEUiFP1klzga7S75P7jXlvU//qLy
         NVqoF8nXLBsuUyElJXn6rVKOR5l6dQ8pl5168p2EvF+z2k8RrDvkJLKEgWM4qmPzJSbf
         NDR8YWmmBwGxZL3eGaSoA/WeDDmIPKbrxVWtAnvewrt8nEOGdfvBjR4q41rLZUwcsEoV
         lUdPA4ewsjUJI2JXe2fLNnLD5zyFvTYZzK+aIT+HYZEoO+/gLAAiFUFOo51cs5/7PxhS
         XQFSyYbNV44jE2Vt1v69JS+ViJ/MR39qidG69f3xT3BAU4yV1t/nVEa3JuFMmyN6VLT0
         njLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFetPuG3/SFMphlr5o8t0Cafb3/GiFIw/g5sdXQjtuLBcSgVfA32VTsYUd64hMfHqSTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9dl5uJ3Eo6Sk1CqKR8R/t5J5dzmCBehn06y8zkopf1KSDD+F
	sPsxJHqEFZXKk+DZG/TleOaoBUC/tUjYwk0dnDDBjZm5gGpi9cKu+a7nfN9tHwar6Is=
X-Gm-Gg: ATEYQzy/j9QZapknRUlyizfrPiuZAdLKMBl3JWo8lS+09osL7Pf3cP+aZCopnpeqLU+
	sNQnAHuFIUGDazcn7/GYxFqrNCaV4Wv9CIhz12EX0reEVhokDXxF+w/qhGwZ+kSjXn64ggGHO4y
	nCQCqmE3r97yf/1mU0Fpim7GWWcM6WcBTz9XoiM6LjCvyP4b2uEwbpEC9199b3yyBiOTjtl8w81
	nGWr8tKeog8tt/k26l4TJurLVaXPs2bbuucQm2jh1TQquM7UIWGzkOL3AUO6l/3kng+UvGR4zpt
	W0poHhvicjziivD3hDo18fLP7e3lhBfw2rmWBQaqq675FEvgRvQupj6Ztf/zf5BFVYYZoPuaGWB
	VsmOnWPXA2UIYRwf1Htj3sqeF56m8Z1D+Iyjmuhm+6jp1o291SCh396+hyAdTbWP4I2sNcWiNku
	pg5qC46YhUkEtoRLs=
X-Received: by 2002:a17:903:22d2:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b258c733d1mr25360975ad.36.1774889135767;
        Mon, 30 Mar 2026 09:45:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765d3esm109007305ad.47.2026.03.30.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:45:35 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:45:34 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, andrew+netdev@lunn.ch,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
Subject: Re: [net-next v6 07/12] net: bnxt: Add boilerplate GSO code
Message-ID: <acqorhF1vo1VQjO3@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, andrew+netdev@lunn.ch,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-8-joe@dama.to>
 <20260329151230.7acacbb9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329151230.7acacbb9@kernel.org>

On Sun, Mar 29, 2026 at 03:12:30PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:26 -0700 Joe Damato wrote:
> > @@ -891,6 +891,7 @@ struct bnxt_sw_tx_bd {
> >  	u8			is_ts_pkt;
> >  	u8			is_push;
> >  	u8			action;
> > +	u8			is_sw_gso;
> >  	unsigned short		nr_frags;
> 
> nit: maybe group the is_* together, IOW move new fields before @action?

Sure, will do for the v7. Thanks for the review.
