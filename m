Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BD3DA5DB
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070703; cv=pass; b=pxE7SMqGPk3Yj4TqCJf+1tJL9B4RbpEzdS8EgGTa9OmDRRMlmm8mwhNIFJ66NjmNlwywkTRkKzCtqNUT4ZGaDu93kTr3v8vMCWiFafEJ+0tebjwmsYF8FJuuRCFYx5zI7sGN+EbYgs1QEL2MHCsq/UcJm+dzDwz8e3ulkc/1lFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070703; c=relaxed/simple;
	bh=i7JNzfUe6L71617rex6z8v70eZaGxtMc7Eehjt1ygA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/r/rQj6XoS6iMXwdl4syQEmMM8Cs/69x0Qy8D1pUOg9F2tmSQauJtLxD72sYkgNJ9PQ6ZJZMB/VQBNuxjcFbcBt7ua+rs4rC5kEdJLOhMhijTuxwPEPKk3ZvgDWH4m1pRS313U0LA3ZTTTMpNcIwRUY4cnyK1awyidBpgonTwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTgs9dCS; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTgs9dCS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b78b638eso9015153f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 08:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070701; cv=none;
        d=google.com; s=arc-20240605;
        b=RiNuzf2zyceSkMuA6Z1Lb1mvbnM5csPlCso5Uiz17XBpK5479sRASlPDZDpRbKRn/s
         /FQbAjupnYEC0OTql+1VDDig58h73wQ5BGEHqf5wrsSaOZtQyzW2oMl1KGFW80qq7+bh
         e8TNEUeoFPk7f3SM0PPsAIPX89HIiu6NqCJFQRszxywq6eP0KFlSuy052ZLBU7i/sCqC
         BZiHTHPbh1hivLfshFMQFZcP5mo5aM8SKKWUXUc90fWr5t6xYm3iBAIzKTCngom/XVoa
         nKlu9Z8zRjOIFcNbuZAql8FQiBTj7FOnY98SqUG8FpqYrZH1hKUMH7I7RpXUXPFfa/Vr
         BL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7JNzfUe6L71617rex6z8v70eZaGxtMc7Eehjt1ygA4=;
        fh=7+i7YLHPyzBz3TC+apeQAkeGgLu0DAtff7zZkd8vsUM=;
        b=fvE06IEtWs3QDc6CoFOFNpVO9GL21m+yBv7UgliBMV5CGyRKRRxl1K00WOi429huQx
         /J/EVw8eLyTF88WSSvsOVbmHFhA1NbGL5B7Ea4EVqsmDaqnreG0otTa5zLp38BiotqYj
         iqMCZBVceO4q7YQsDQLPH9hsOi8UBDmxQn1xy6GlrlKZiyK2q5hsNZcC4xgxkUghuuZC
         sAVPLRFI0x6gwWlwiRzq4hJezj7fSA6J6DmZ6WDo21tFcsppSMyHdR1rnUc3qX4jRAQR
         hTt36hxXoLFLgzyjmhVwivOiwuVKvzLPo0rwVx2WmqWXjyadnofQTYYOXmG2nxJi4J/O
         ye8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070701; x=1773675501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7JNzfUe6L71617rex6z8v70eZaGxtMc7Eehjt1ygA4=;
        b=UTgs9dCSN9J1VFSBF+pF2Rd0qYO7d6F+7+ilEf9e1FSzbRDMf1bWzjsm91pXB3tqX6
         EvWU03LHBkbZ4f/FskdKNXJdL3f/zITzKLnhKaZjrmF4USYesZVPNb2WQisjSgne9nU0
         4XIJUtgan65BjxHhBkcFU1enkunoAAiuZ7S+TpVUjI97HhVYDiA6SKJ/5IxPuDIGs3eH
         CN6RtBT12pOc+5jvPqqyujG/UM9lKBlIj0r6rOL+e4isRwUgMSwBBkkxxRsxIL49s31F
         eBqClmmzYxUyGj1xgFE8bjd1NM3/o5Ak+4UoC3x9Z9XY5MvcsEAcxon9CVUINY+f7ZOK
         R1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070701; x=1773675501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7JNzfUe6L71617rex6z8v70eZaGxtMc7Eehjt1ygA4=;
        b=bGdEldh5roBl5kfQfpqXwNwKjXlK0bc0uEa61678w9o3npNkJS8MTguN+RMDAsJGWk
         ui1Q3Rw6O0ASEnY4RGJfxCCufMsY1H0kw6sKcuycZJGcGeTRDAObZT7WcrzDrZUAQy5G
         BwgKm7QOPfZ3VIxOXSOrtxE8rZKmKMvCnTNQFu06k2wAbNkwCb17/fk80lm0yP6sAmR9
         xbsqPGvbP+0edgFy3ls5CzIL7mvObUY3axaklutBBWED7hyGb4YfDQXxVHTjSAasEXkw
         wiNWhKOzikItQW6Ak4GEv/dXuf1IagOdDvaAxY93ti59P0Oq2lJpNUwntHv/Ebln8Yxm
         Qikg==
X-Forwarded-Encrypted: i=1; AJvYcCUzFeOtdX8ERMUZlqkBo6yZQGkdXVc2fzF1UYCXJaL+qdI0yL/k21lN4fVt3KQp1EADi3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5p3WUN/5Tq5hdqmG7Is8fJfi+M5iTRtdkq9sCYhOzfY1D/Lf
	35xMamVRnvIUJ9PVXTnSsRry9AyOwWoU1mQYW8SR7Ay0HweVnVhnc6N8xRWlhGej4uFr2I3d1xq
	26vp0ugHAr+zYtPWIAarFe905/+KbGSQ=
X-Gm-Gg: ATEYQzz88nUvfY6mLmbfv4f3k8bpN862U477W34bCxSZAT3scnhhHEUlpQ+358T9IOZ
	b5E9kiW3GddVNqmvMVjB6hAWhg/rNkCYGr1J48W2/47oStXnmKTlDT6pTZbIJ6utE8G1mYVvnLq
	GAmEMClJd9dlKIPToEyQt2++atljdIBGi72orEvM758CB1VDBY1tSc9DZVMvrEvvG0x5pxBBqmx
	H63ndLaYDbRZS1I/YeTkOZPwQugIjuSTbRrd3eTulsUpDNj9UAdx0I713KFoeSCovCQplgWuZwm
	OXJiNi/bq6M6k0R3btrfDxLrBvaxTQITP//hAsZTMVbI/ld3Hs7NO+Mxm0KBanyhd54lZr0e050
	iJT30HVfRyqH3RYQzT2dTXwcSRA==
X-Received: by 2002:a05:6000:186b:b0:439:9282:e728 with SMTP id
 ffacd0b85a97d-439da654ce4mr21389898f8f.2.1773070700491; Mon, 09 Mar 2026
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309121033.2594457-1-bqe@google.com> <20260309121033.2594457-2-bqe@google.com>
In-Reply-To: <20260309121033.2594457-2-bqe@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 08:38:07 -0700
X-Gm-Features: AaiRm53_ONUz9DQEgma8C2U4sA8fACZSWuQaDwS63ajlIU5qL_RrY73qp24EXW8
Message-ID: <CAADnVQKNiSm44Hv_o81CQ3Phv9t0M3aXcWDdsNm6qvjFzSJN0g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] bpf, docs: structured docs for the verifier
To: Burak Emir <bqe@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 5:10=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> Multi-part docseries (verifier-formal-*.rst) for BPF verifier.
>
> Provides some background that helps get a structured overview of
> the static analysis that happens in the verifier.
>
> The documentation covers:
> * Part 1: Abstract Interpretation
> * Part 2: Abstract Domain (Value lattices, tnum, pointer provenance)
> * Part 3: Data Flow (Transfer functions, ALU ops, bounds tracking)
> * Part 4: Pruning (State equivalence, subsumption, liveness)
> * Part 5: Advanced Contexts (BTF, concurrency, reference tracking)
>
> Signed-off-by: Burak Emir <bqe@google.com>
> Assisted-by: Gemini:gemini-3.1-pro,gemini-3-flash

Pls don't waste the maintainer's time with this.

pw-bot: cr
