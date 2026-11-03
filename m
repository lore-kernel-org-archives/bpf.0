Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741784;
	b=R7NlJ6k9tU5/dD0+HqEgZcpnRMFMnH66arkJK1ivEpp1hC3QSvNlWmyFbZOZ9F68NiIG
	 TwTRlXwmegHSNSacgJVFQq5uXQj4FyCT+JR2MaUsGBP2p2Gc64f7MP0DOwAC2nDe+AQBd
	 gzYeihKJ4oIBgCKD/K3G25uVtH0TpZsRq6BN29UnSsTj6dZAbbfIWLe0k7/lBiIXUly/a
	 PwI2iI9Viea8D6pEFCkiaP9XMuOkfAsus/atzpoPi4wIgIYH9sZ+intNGUjKzNCyffTo9
	 P5bKu3+0dJsSeXmQao/+Tr1purE7DFRvMhDAbWERP6hzBqpmBlpl4TW0fgeF1gScLSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wiq41JYzn0rdt5xwEVgdCUgOHpCm+f2EZTVSBBYr7nc=;
	b=ITJ/sCGTemFrI+twWrL8HtjAQhHiiui6q8/Xcs/lyFsqwfVqMJ+ZprktIZ2+oB47VaBu
	 DV63UJAa5aOKr0N/F8ypdcLDDneBcrRsHoQbxh2MMeUG7ls5zrBt3TWquVD0PhQMiwYVu
	 CtaTmOGor+VuVoqDsaT3ymNjwJeXx/mAY+imOqtJDPwGa0WYJd7VtnIStNoLJreipGc7r
	 HmF6SAW8bttDbjCtcXy4ZPBEL2wrqBMYOV+dHi52nhGVOaZHV2s7CVH/EAaamR4ug+IgH
	 T5dXu50RQ0EvCK1d4dK4OLwTaw4DDH5Tu1ullI2ULY9f/2ftiIp4vnXZgCprNg83Dow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JS8Vp5ij;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4248606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4248606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JS8Vp5ij
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso29671f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741782; x=1794346582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wiq41JYzn0rdt5xwEVgdCUgOHpCm+f2EZTVSBBYr7nc=;
        b=JS8Vp5ijJmH2ADwGR3rGuAZ4BugW/5ja1qZqL0n7rC/b+vXmpH0m5gAyc7+dPzHH5b
         5Dd3DuzfsfzH3RLipAii0ZGBItXTTkm7hdMY1MXc3juHUWf7QHz2Pz6qEJfHfPJ6Bvnw
         3QLu/iLWo6RE/D4qJaZo6S/DcijtQXJ//KS+e8wPpBk5/y3jH7VN6rSAtmJ5Cc3uq68f
         HyOueBqb1WnEU/PIFYMRMAXogE2ec2TqHqDtYryFdjcNvmY8ysdo+hEsl1yqw1sSjgj5
         ipZ4MNjRaZ6Awn/Z0FY0an1BPe7ygKviLEzYhFl+JG/+YqwGqPGmMNr2Fhr3i5oFMPMz
         pLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741782; x=1794346582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wiq41JYzn0rdt5xwEVgdCUgOHpCm+f2EZTVSBBYr7nc=;
        b=FEaYZb7hsbS4k8AKP2Pwb5WljaQkTNzHdT+R9gxeqk2cuW3OLUsLDjrH+rN44N2GUe
         lbN6KqdvRG1FROrxtU/Pkh5RHZIC4rnSBWOSERikc8MQsstbLMvFzOCXHOnYd7HVlzVW
         XFUgzrSiFR1c0axjDeXFuOgJyYw74u1c5DNL0IxLWp8wOjtcwEM4QGvHqccy4aEzOmfi
         wbPRwmV5bCY5mzmAls3OIk9djVXELwywh9CU5fZi6XqxqeqbR58h/FlJDWjkFlRMF8Jk
         foOzePO0ZfNU0EEctIYUEuDaXanygo1SobVboLeGhdgqLxybQArIjxVTyyxEjMsr/Tt8
         qQrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxX7KS53zfVZ36b36ez8/c4K9HEzTRYCxP6bk6T9+hOAThhYPmEcvgRDS9/iNrrALFqMsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gu1ysicOBH1AjJqQHBfbn7mOZ/cExsm9H8SzD78iv3iGHu25/
	HRp5w2WhkDH3GFp5rvEgTM6tLF9mlgycHbI45ZnYdaRSJy5v1QIB85bX
X-Gm-Gg: AYBFou1LBs3QXtXuSvfPyjDbD2V3GyFfQh63B1vPvbLS+KjAraFQ4k1KW+KDroOpLMg
	Zx9IzgOFprHdo0BVcUaOMAjRiFUIo15HD2o5X3yC5poiLSfxOXuVK6dJplTBPXKBM0mOgaZ4wJQ
	g7WRN/PN4NTGb0GimzL9ed+MTXf1l/RhFbGt7wZed3NRXFH3LRkFcAJODFpeVZtOy7UnMzHE23j
	vNSLkCyosUJNh4kEGNwEASGlSBP9PdP248XN1yPzmGUr+EokbEbvgkTx75xG6Pxd7Kb+o8fHWjb
	7fcyjBgFafB/kMI+yTJgXaWDpIWfUmIE8qCNVcywMHatVuf6IUKhDboxhP2IHAFkn0vfCAZQRwf
	/iNNijErVNs5Q0creCtxo5mVOsucp4mOvWIcZZ9YGNZG2oEd2IyMome4RMPT+vzWsbx2UPErWk0
	PTJ23qrBZYc+CprAuNoqsFpjlKtP2cfQjaAeTWK/gsM6gu/TBZt42HEMjO9PsgbiN0dK/d9hBrH
	Q2MxUA474zPBSzPxH5GbAXs6T7BXcT46tw2+z7fYlwJymHybcYRU7mCmomQf0G5EQ2UCv+2bpKv
	2zVWTwPfzX0rQyY=
X-Received: by 2002:a5d:6f08:0:b0:48d:f877:3349 with SMTP id ffacd0b85a97d-48e6e4f8cf7mr30803501f8f.42.1793741782271;
        Tue, 03 Nov 2026 13:36:22 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm120549f8f.28.2026.11.03.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:36:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Nov 2026 22:36:20 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 0/8] bpf: Add user memory kfuncs
Message-ID: <aupT1C3SvA3Gxrkz@krava>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <DMLRZ4QCSGYY.3D2G6VQA28CBQ@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMLRZ4QCSGYY.3D2G6VQA28CBQ@gmail.com>

On Tue, Nov 03, 2026 at 06:08:37PM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > hi,
> > we have few use cases where having the ability to allocate normal or
> > executable user space memory would help (like to replace function in
> > live process or change environment variables).
> 
> Too abstract.
> See
> https://lore.kernel.org/bpf/20261016224310.3135990-1-alexei.starovoitov@gmail.com/
> 
> I don't see answers to these 5 questions.

nice, I missed that.. will add in next version

jirka
