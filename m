Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD2347533
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754083; cv=none; b=X+M/s8ypclzqpIZF9aZ/wyMjsEM7BPxe47tzcCw2PSARKTGTo+SUqYxf2UW0tmINUW0+gb12Zwo5AnHKZosuJADjddZa8Dkq7zd5kOEsossSG5pLZXEh+7quaoPHB84auio+6abc5c8mMFbKjwKNOtxH5DdLMoxk0tLUhp3GQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754083; c=relaxed/simple;
	bh=VoJzYIahVdHnh9JTEdbifpNQ3a6Q2jrxG9Ksnh8uVv4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bciJ0gFEz3mf7USeRG2K6VgIc0xLrbTeQN2GyMbX5BcoMweinx7mcsAXR4KP6nY+jDIt/xV0EtT3PlN4RjyJBStOpGY4KFTiQReuS/n6LIDqdMUAl2SE3DM2rh8x9avSp48Um4a0sFKrQU9UYyCKXhvTpmHFsSpRxW2joiqDLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+dSg32J; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+dSg32J"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1273891b3a.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754078; x=1790358878; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZpZy9J+OMiBF/HaJ+IISwGZCp8PK1h7NdQq8bfdf58Q=;
        b=G+dSg32JIoGFVFXK7S+kvuLreq5eQOSwq07ASbxSIvoLTZC4rPPF+JAH8Xti/Yxq20
         0nPlNE+YpokN5axAOA0N4Qq2ZxY3OcVAH7jGN53bWW8QxdrGw4HnavZk+YDBfMfJ8oM2
         RicDG1ijzoJzW9LvvTb/dnM6ZXusvhylDPlDnohHqgUrygHaEl8h0hR9rPP5Ofysa2A7
         t16ISVxao2IJTFijCi0FvxDfNoTMbBunYp4W454d7/lHzUMiXSiIz9I0+v3WeuWTEuiR
         iv4c5wi3XdceCjGM+SicwDYDL9eYzMZmy0xG9Tz1X/p423IJoeJ7kuImr4LXNF4TmTO/
         JlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754078; x=1790358878;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpZy9J+OMiBF/HaJ+IISwGZCp8PK1h7NdQq8bfdf58Q=;
        b=pe/nzjnPkch+KtgSuiE1a1q0tlXwY9cP6q59O4bWIF2RMLOoczvguZJaTcmUtOx86c
         +SQD6bJl+P1/ky7jrnTkdRhUWfDTE9Aza0oicQuXOh5Yx6ZEjbJu5CsAr02fNOYgHTdU
         X7lwdiVUG6FMQKr3HGTi7vk0IR8Y1Mr0bTambIwHT6b0SOWi0I4oTXQ1ixwiKfh93ddw
         lkR+PMSXUUZ0EuoA3/iUw2Bbdy4sr6/MKLs1DNP0FdHFiI6ImZHS1X/gYkUaJOU6bvS2
         4jV3mPN+tn1ZlhKn+pBgTOloRrTQQ27CWnFtaJxdVZFzfepW2HXSBtFj3Gx6O4yXS6Xb
         xypQ==
X-Gm-Message-State: AFuF++nMjUUKkqhebqgWBTR++D//RYDdgKl6j8+/rELR958+xjIIkw5D
	w5vJ+Dkgy06MB21Xyxdcxbz3qFgmiJJL5OadlDCyfY1pR3HXm36aMN/k
X-Gm-Gg: AYBFou0avpNRmWGYsjl5v2+yh3ETy4af3xvzFwWb1Dd133brmycfqnRxDY7WMnkpyLK
	4TGFED1p/9P2TLSTG8AyLs3xxxqUmMeOR5GAW/uVfm4tsiGszoVQ77fSvuQZG5/i/14uxIirrKX
	vdKPDaluul2EMJM+jngJ4KhmsoX7ijVjUu3CTQMsG4XwYJBCBHiVoxlB5R8U8WS4IQG1wQie1nH
	iKOjp1ZBzWS6UrKYdo+YGhR04PPvXaUs3MPrTVclj94XHE9PGMUuvIG8+9kipEDUog52mAbSJ/G
	AQdCd/AM/CDozB7K4aNx1k6l34s2iorR5jApdNC88Ui21/8r+AAcjSF5+O4k0CYxBT/Y+Ww0VRH
	BxF30LLwalxV85VU3L7M/7garEVpVZieQEuuOfk5+hCoF7SoX4rm7jLoRYvQEHcZ9qZ2w3ePck4
	7PSSk+ntbjz8mKt1DHtYn16fjye2n4Phi0tphTS9Jsg6Iaxoksvmy9KG/vJu6PL+iuEoRoaqHVS
	Hv+VohaWGvo1bxVZr0+BWfDjO4/Yaog8LZrh6IFb8UopD4nXn88UXr206kf9rsKRXf+nd4S3dRi
	gU7TiA==
X-Received: by 2002:a05:6a00:b49:b0:86b:4138:4084 with SMTP id d2e1a72fcca58-874dc7ed67amr5445922b3a.15.1789754077474;
        Fri, 18 Sep 2026 10:54:37 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0c516sm138518b3a.34.2026.09.18.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 17:54:36 +0000
Message-Id: <DLIMVC4MY6XT.22U1NMBVLDVM@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix task work round ownership during
 cancellation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260918080014.54012-1-luyun_611@163.com>
 <20260918080014.54012-2-luyun_611@163.com>
In-Reply-To: <20260918080014.54012-2-luyun_611@163.com>

On Fri Sep 18, 2026 at 8:00 AM UTC, Yun Lu wrote:
>  struct bpf_task_work_ctx {
>  	enum bpf_task_work_state state;
>  	refcount_t refcnt;
> +	/*
> +	 * References to task/prog/work in the current scheduling round.  The
> +	 * STANDBY -> PENDING transition serializes initialization from zero.
> +	 */
> +	refcount_t round_refs;
>  	struct callback_head work;
>  	struct irq_work irq_work;
> +	struct irq_work cancel_irq_work;
> +	struct irq_work destroy_irq_work;

This is overkill. Find a different way to fix it.

pw-bot: cr
