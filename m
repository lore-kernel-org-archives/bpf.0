Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A0399899
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412257; cv=none; b=VoTv+pzPgmgZbMgyr7ERwb6SaaLQFqS9EyO+dD6nQSrAdqJF4qxhIVrLCAN442M14xtkiSX8DWEbhVN8aGZHpo6H/5nW9kndU5Hg1PsLtS++nux2zxrj/8ewxaAPt6rxtbZA/fZxcKXRvS3UZKpf1Hg1otEa16zL4XwTXmGjEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412257; c=relaxed/simple;
	bh=357Ky0nTuRm/ryxTVFvvXIsESqKMl6UKRo2AemrEjso=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=X8GmUgjMUYFIlA5Vir2l28Ix5XCF5FgLxQ+n/Bea8F/HSPzYKM3GtC7f5UcCNPK3M2v0T9XPAaOdfQGE1OR90rUSDxnDerKUVfwf24FXF7w8wKSXvLMzbcClplTLaKcwlhbnIggFjpx/KMKIlUlciQNOCr0rX3PruZP11wYiUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mas/7Xjd; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mas/7Xjd"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df8bb777e4so5852865ad.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412256; x=1791017056; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpE+f047+1AeIBfIFik5jfpCl92Uu0imNFmaxvJId70=;
        b=Mas/7Xjd1UQUnz84T1Tf3pf/boSVJH44uQ+tp42u0B1BDDviXXx1zsD0M9kI93zevQ
         yfAC6VboBxq0WvrTnEsKvDNISjJ+kG0puPEsBqH18oUeJQMJMsqyDbT+jCdCTUyUtTMo
         SKLnm7hfRpT6eIO+l0mf6FN8uK0Btkh+SgEgadt1kuR4yz067kf8B45WWgq1OtSzgi+4
         fgW8BKD/u4aElvwYHypbKueZooSR3q+xiK671Ykv50wrztzkJtV4IbC7559UCnDG9zTQ
         dmFFt+5A3LaJwJ5b/NXKnm8Z+YdSOEHrZgcoUJV0L51GfT+LdO9U26dzEQ2vhsqoAVOh
         i5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412256; x=1791017056;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpE+f047+1AeIBfIFik5jfpCl92Uu0imNFmaxvJId70=;
        b=g3POniNnd/c7xIczSfhr0vVoEymQnE2z3kuOyGlUA29MeClPOgFBl/832H9ZK5VDof
         4VzY7I6AtPl7jCUq1LNboIqU5xAgiZnYTOUiBhfMojfJ9fKUADgn9cYSbaHsl5P/wEDH
         PKIwRTTVliqyRNFRSp3OAtxMPZvwAEQAMmYtT5nwSnU8c9+rDuyO/T0ak18/jeNHe9ki
         Oumz0X7AxbrAfdJ8HfC0ER+9WvQK5Ssoz29kR+s5DpwJ8LcRADmX3bQUoazjt778wHod
         wOKFmHID8JDYAVLb/K4DBVOhZSoHhBSNbv0wgVPiax9Jy0xGqBTS+DKjEnjygLBK24Su
         vvnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW/SefFoenvzdnV4GNpUI8eHuigful/d1IZvsKFrSDYlw6ThXKTGuRIvOgxp89oVGYoL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEpvNj48HNd+0Sd0OvP8VkAA71nrHyBqoghqYRBEZOvX0Cjkjv
	IA1yn4nC4OCrb2NVZ+C+4DnGJ2gP2ugLsvafanzbHBpd3JFyIRuEHYbF
X-Gm-Gg: AYBFou0wAnpBAr2Wd5XIMSJEWXy8sGCEm0GTn/lRC6qdRkIpFtE1fxWp5eG05hx+H2Q
	5e7DAsurmAMQ/jG4hVGzyuA4kFZebkwjA47knOvsbOpiw37gTxbyZubYlX1gj927OkmuZyXEjj4
	2NWLxIx3pHoAKjkZIZYxxyN+PVMMGsryEOC0aceTnsqQcUwxE8ZTXnbsVduKdc2+CANdpxXO01A
	qhhB78o5ZGMCqWDnUttcUX6vaHPSKZw56/1PqllHYT01oGS0GwCK1slY7fYcSpdf8GMDst6Uuhz
	tFNdbHOgsLzRLkUS/1zmigWmIdOF0ScX3AkjJbbGsDS9hwHOLiwDoKlFWuuj86dHIjEu31ZLtO4
	+EnxvJjTjlP/+T1SI9lY9l3VJUeYWDqYSViL02s6AczVvc2tgokI+OWb+VjF7/CGWVh9seWvs9t
	oj62HKUIkYnApJott42IPzxZPBTCtHToQl2GCoucLFMNVTlk4FDfQ9CqGQex4QMjejUQ1oD5hdZ
	BdM9+mvfo1jhCuSIcDnCQdrzosLudNytZtMMegnSKzSaAUXxcOgb4qBrRq5w1Sf07/9Ql2FiuWO
	ko0sF9xe7j06PA==
X-Received: by 2002:a17:90b:3143:b0:3a0:d42a:e22d with SMTP id 98e67ed59e1d1-3a0d42ae4dbmr2114046a91.56.1790412255695;
        Sat, 26 Sep 2026 01:44:15 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm6408824a91.7.2026.09.26.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:44:14 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:44:13 +0000
Message-Id: <DLP46AE97EYD.1I2HDPGBR8GME@gmail.com>
Subject: Re: [PATCH bpf v4 2/3] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <florent.revest@linux.dev>,
 <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
In-Reply-To: <6a6d43e6bada7a1433cd525c9ec31780ed9b2401c8834894defdf671601b2f1d@mail.kernel.org>
References: <20260925100342.481242-3-florent.revest@linux.dev> <6a6d43e6bada7a1433cd525c9ec31780ed9b2401c8834894defdf671601b2f1d@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 10:47 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +	/* nops for move_imm+jirl, patched to skip this prog when it is detached */
>> +	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
>> +		emit_insn(ctx, nop);
>
> Can a task preempted inside the skip sled resume into half of the new jump
> sequence and jump to a garbage address?

[...]

> Could the LoongArch skip site use a single instruction instead? For
> example, a 'b' to the skip target, which is always within the +/-128MB
> range of the same image, patched from nop to 'b'. The rest of the sled
> would then be unnecessary.

Seems like a real bug. Same issue on riscv.

ip_after_call was patched in bpf_tramp_image_put() when the image was
already unreachable. Now bpf_trampoline_remove_prog() patches cur_image
before bpf_trampoline_update() replaces it, so every call of the traced
function goes through the sled while it is rewritten. stop_machine
doesn't help the task that it preempted in the middle of the sled.

Pls fix and respin.
Everything else looks good.

pw-bot: cr

