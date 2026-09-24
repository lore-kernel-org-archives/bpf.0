Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01941316199
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215924; cv=none; b=WLLHauxOQWsVa2TZjprEz9snfPQD4xVLk80qFxUvQBLUcp8bGia2dMS+YtS5fS4PLgL8+WINfRRUot7YigTyRAZHL+MKhNqao+guFA5f/R7m3Jn2WvQLcVkZEOjtgYDOqMaDbFCRr1rYvBysMBSSu6ahSB99MqzReoHXoHRUfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215924; c=relaxed/simple;
	bh=vdYManPEtHbXFLL7sZEQKBQRAMxvpektfS3/MzLmJ2M=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=GN0bz4rN9oJxaJTcruw3g7EABmKQHFV6vFkZTUe5DOh4EwnBvPMmzeXvopOhemjjlp110OdOcMJ8ihF7VUx7j0vye2iEynzy2EE3u0oSu+HLW8E4aV4J1tWcSbecsfkW/P7pUimFbhF9odqxQ8eLOWKybYfhgbpqp3uyVJzAXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvWwxqqG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvWwxqqG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1104319a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790215922; x=1790820722; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZtAyZpaHnexnYtKpXQWrU44CD0JD4ASMW0FczcTABoE=;
        b=BvWwxqqGltauBPDKqXnhjC+AHQqWiyTe2OsCTQQgah2uMYi2DKSgpbduQjELIRvDoP
         FbyyRtd/C9U5zJ5i8GeL/RHB+fuaa0CCy9TPMUU/BEsJDGkCUCuoQGB5o44XSa6Bq4vA
         aVYdWcG0UlHkyrwFyfpJLu40bcT6u/sSN6ATXfalAaoYwjAH0Yr4V/5wteI5RBxjlFXO
         mkm7aUH4IBhevX+hSNItaeBCIltBNowDML7zeAIk30ibbdJeC4Omm+3atoaEUFd8HvEy
         ecX1EMGfnW8dC0BSgHuQVUQmpvAZ/3Cj8VSSn5U4VooGAYKj81zQ7C5puQ0d9lEYMlBC
         bXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790215922; x=1790820722;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZtAyZpaHnexnYtKpXQWrU44CD0JD4ASMW0FczcTABoE=;
        b=z0O+4zaEOFEFdUdgaduwiNtyeJjGLfZM1QNcyQaNtAgDJ0yt6FReMKonvXbG7ls2YY
         wik8256olwELs/IjFjvCYN35xlWKQ55NapsToJwoD0wTIt1JcSCi94OIxoCsEq2Wr8Ky
         YE+7Pv6aJ/HKKsBNQe6pfTEzjeF3kWCAIWRjZfCdoBcxmRCL23UsUO/6QB9pIBSDSxGv
         jNLnxGDf3c4GS6GANp/+jKKAW/GjmIjE7j+Ry87SRrup69Vx2OpwsD267Ei6wXg2MWUg
         kG4p4o+wMWjfSS+cuUwO/ce+vHBFga8633mQjs/qBjCc8s1TtGqG66U8cU7fnEzkBl8E
         vJyQ==
X-Forwarded-Encrypted: i=1; AKwUvByDFTbLcj7iCT+uaZIKYSwTBbhw6BZobeDJFATEqKcjgEWp8+5iIWGBZX1tqVLG2DVB3Hk=@vger.kernel.org
X-Gm-Message-State: AFuF++lRU7vq2eA2lnK6M0Ftv+SabLbSyMYWXA6tUh47ZymnMwU+9T6S
	PG9DSPPt3IZdShvdbhMRj/h5v/cpcW4qHZIO532QLNqsai+cJJVwA84R
X-Gm-Gg: AYBFou03AEb1gE7ndxResjd7rU9lcVvoY7pooW8xAnD84FO7K/pmbdUC69wlOyBefQY
	qY5UcNWQwTuMpE1HKgTYDu8oGM10E1Lz0vdc8h8jxIY3IKWdFr05TdHHo04cAR4F81Lv/U+4Yip
	BA0T4t7c124DM6mYzONXYy/FvJJix8G/0xZjb196qhUvSJ5JuyE2romTVM4Cz1YSm55OWj6AcVV
	Pk5DPFuWlVMIgoeYrudYXAC5y6f9yZFE3V5dzr91vahA0TV0/nIxsDR/+UsxNvCiSdOZ7Ymh0qy
	DUWHQK6/Y20bbmhMTqqk8T3Vkg0CFGZXOpHrmaVU1y/Hc1M03itnPBVK6b4b8nMsES560GqZHA1
	gnjBUIVZZCFDWgPpZimwItovIKTNJaidoiO8y5IQkOq6Syi3RqVa0E7uQ6aJrp999nlFN/zsCtJ
	EJ4wk0+7bomTSdUL1U6KJBAf0rDMTm+/DayeDOodVJtP7zJVGrFQcpK8plmhMjPK/EgHDHLWttR
	Pl0HP0Xkr7n24IF3t33CibVkp2fnXrgA4h9cXyoLaOg8Jif8UMyeE8aakQcf4uNoF0utb8kjrYs
	hc/P
X-Received: by 2002:a17:90a:d645:b0:3a0:2817:1fcf with SMTP id 98e67ed59e1d1-3a098ae68f0mr665404a91.11.1790215922025;
        Wed, 23 Sep 2026 19:12:02 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a08132842bsm2583725a91.4.2026.09.23.19.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:12:01 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:12:01 +0000
Message-Id: <DLN6KWMU54RL.2ME06QRKZKCQ1@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 10/17] bpf: Recognize pointers to functions in
 read-only maps
In-Reply-To: <7f1587113ee73116a351e6a5316e2b8f7485b1cdb69ab60fd56ae9069e98d767@mail.kernel.org>
References: <20260922011323.1298619-11-alexei.starovoitov@gmail.com> <7f1587113ee73116a351e6a5316e2b8f7485b1cdb69ab60fd56ae9069e98d767@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:46 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +		while (i < cnt && ptrs[i].map_off < o)
>> +			i++;
>> +		if (i == cnt || ptrs[i].map_off != o)
>> +			goto overlap;
>
> Can reads that don't actually overlap pointers still be rejected here?
> Looking at the bounds-based overlap check, when a vtable-like struct has
> both data and function pointers (e.g., struct { u64 data; void (*fn)(void); }
> with stride 16), reading tbl[i].data gives var_off with offsets 0, 16, 32...
> where every tnum-possible offset is non-pointer data.

That's a limitation of v1,
but sure I'll try to make it work in v2.

>> +	if (env->func_ptr_cnt) {
>> +		err = check_func_ptr_read(env, reg, off, size, value_regno);
>
> Does a PTR_TO_FUNC loaded from a map force the program to be JITed?
> check_func_ptr_read() marks the register as PTR_TO_FUNC but doesn't set
> env->prog->jit_required.  The map still holds the byte offset (e.g. 0x40),
> not a real address until jit_subprogs() patches it.

Will fix in v2: the read of such pointer will set jit_required.
