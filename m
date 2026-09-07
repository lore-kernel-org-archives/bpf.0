Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB74CA77D
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788492; cv=none; b=bKtxcZf7RDVHvsWFbJ3eM3JAqe1KsI1YyXqDMwZHLwVv/JUluHrZdeD2hKBC3mJhLzAigPApq45h70inXBzqJ8HRINlLfy/Nz2PZTmK3cVCrUnQcwIwy1JFUDN3oZ8o90yNUlgnsMWQbnbUVOr4dC+mfQA7jtCNsUTIPP7oidXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788492; c=relaxed/simple;
	bh=reyY/SSEkR1hnlm27/oBWU/HkTc3wy99JVkrYnF7+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm+uQfySc5ZqJIywGqWHz0+FHk5noqHY8iLyg1Kg3HOCAENk8mYciP5IXWbtBjLa7lJayES6lXQeWlt0Ow9wDHAac6FilZq0f/OQXyz1lYNmUGT54sQDr1twX4HXMA/Y/VFlP9uJ+MQ7LmCRO62qtozzTMiO12qqX3ACi2lr/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exG3ufYi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exG3ufYi"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48589798dbbso2939118f8f.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788489; x=1789393289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdqenWViU/7DdrPY02Ze4qYR4l7SaizSPWmzY+qOqso=;
        b=exG3ufYiFIIwXt3jURMEzeZgTYsK3Z65iqYzEr/rVOfHMDC9OI94A0jy2eS7nW4ONi
         gQ0m595vzrD+Up4219Dzd57XMet9jOPTaf2m3f1RvBHMcM/ZXZ/5rzdxYNoH4etFMdrR
         nNPSJ73W4CBV7Q1N7PxgCEItLctTeeWJCMnNBxEf0JkaSZsoebjodE8RiD8bhkLlFWCS
         NS+Um/pr0gZY+w+hxCx87bmFey1wq0kzErJn4dc19P1h7BvaC2HF30FJxwJR1LFJ8h4R
         3Sf9iLMXHvHC8uZlin49cJIVLWcBGDE+339DQyCmkfgTdfxldD3FfJ7j57uukBVCKwCr
         /0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788489; x=1789393289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdqenWViU/7DdrPY02Ze4qYR4l7SaizSPWmzY+qOqso=;
        b=MYHF3dZh0c0FgvHiMDnayrw4Xsytgjz+oLyostvAIqbFcya3cUOVpqRYt++Sl2EJOx
         aYqrTEUIddY8wg90hvsMT5NGG8/UHKzjz+HN6OrLIS2ECBvMTbiXi5TVZ+nhXP4VYGFK
         OufVaJMCqfDt2H4O0q1l8cSnLpRVy4rMAzdzcfX0hZaFKobe6VblkNznG2goSWRj1vZ7
         zNXkgHdrg8ZJWsv5CIEcl7CXjhHfn/XMtpusl4Sw9hVbf6iOg/CldQZWJ9gUD9Cf9JOH
         BTVp2xOZyL+axm9bbLLUF2POBF0kviPJ05+JyPEU58CxAx0DyDHt4qcNyusNLkWsFkVi
         4c8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxraZK6bO0I52oQiDRf507QSCMLpAelypBpqx27Mrxf7VLsoV4DU7CqBiV2P0n/H89wMNU=@vger.kernel.org
X-Gm-Message-State: AFuF++nALkOsFGZDtEKHqeKR/O8l17d6qryZ+jLP8O80Dde6JE3Z/YqO
	CtXNS9IYVy4eSVn8mfUo1IqMA5DS0H8MhJheaWzSOWfFIPcr7/tDTstt
X-Gm-Gg: AYBFou3G+D0b+6yY3UnVmmdeTb/qRQEDbGNNOUwiKrNqZnINwex1Vkoeoq0BwRCYnRV
	e2bfka3B1C8y/rccNtsmHt+HRvOhFh+ZKtmrb7te3LQZtDeBqXWQii2hL5pEj9dURT75JKKzt9K
	a2i0Qu86vm4ZAVnhibWTuynNTP0w6CsjV2ntodRsh/xJNFeviiyGs/DnTLpNMEnqKhBxU/9Od7A
	v1nnVoKQE3EMBvPtViqXBcWNZxNIaUY1xNTAS8DIYVQIT8d+eFRA6cT+nqWgG/ECQVkOKJRr9B3
	quhOqY4NyU6hegF3r2vXozfi6GRPRIVY5FdV4C9Yrhq8Hp7vN+nXxArgTuGaE9foRhsLrGTTzjN
	zdjr28BigQ8r/8k+HcKn5edLj/3jxKXqbya8wOeZA3UR5pUdPl2Eh2GIDKNSrVtP5KP2Jro8rhw
	QKnabQ79gQtt4gbTw5U+f+p2kaAi98FWs64tISPNd3DkIbmn2O0Bmx8+qNUe7NRSCiKnsSYEAqE
	A==
X-Received: by 2002:a05:6000:41d3:b0:485:8e90:bf55 with SMTP id ffacd0b85a97d-4858e90c0a6mr18822569f8f.47.1788788488633;
        Mon, 07 Sep 2026 06:41:28 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm28655087f8f.4.2026.09.07.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:41:28 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v4 1/7] mm: Add copy_remote_mm_str()
Date: Mon,  7 Sep 2026 16:41:01 +0300
Message-ID: <20260907134101.424017-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0e4edfd3-0c82-42e0-ad09-19ff8b8d1511@kernel.org>
References: <0e4edfd3-0c82-42e0-ad09-19ff8b8d1511@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We have this check in copy_remote_vm_str(). Why are we performing the check now
> twice?

> It should either go only into __copy_remote_mm_str(), or if there a reason to
> have it before get_task_mm(), it should go into copy_remote_mm_str(). Same
> applies to the memory.c case.

Yes, this makes sense. I will fix that.

> What's more annoying is that both implementations of copy_remote_vm_str() are
> identical, and both implementations of copy_remote_mm_str() are nearly identical
> (just dropping the gup_flags for nommu). I'd like to avoid duplicating code for
> nommu.

> If we could export __copy_remote_vm_str(mm, addr, buf, len, gup_flags) for both
> cases, we could instead provide a single implementation for copy_remote_vm_str()
> and copy_remote_mm_str() e.g., in mm.h? (I'd prefer somewhere else, but we don't
> seem to have a good git for memory.c + nommu.c shared stuff)

Another idea can be:
mm/memory.c: MMU implementation of __copy_remote_mm_str()
mm/nommu.c: NOMMU implementation of __copy_remote_mm_str()
mm/internal.h: declaration of __copy_remote_mm_str()
include/linux/mm.h: declaration of copy_remote_mm_str() and  copy_remote_vm_str()
mm/util.c: shared implementation for copy_remote_mm_str() and copy_remote_vm_str()

This allows us to remove the duplicate code. Does this sound reasonable?

> Now, that's also not completely nice, as I don't want us to EXPORT
> __copy_remote_vm_str() ... given that these functions are "#ifdef
> CONFIG_BPF_SYSCALL" could we EXPORT_SYMBOL_FOR_MODULES?

Now copy_remote_vm_str() is EXPORT_SYMBOL_GPL. In this series, we use
copy_remote_mm_str() without the need to export that. Why do we need to
consider exporting __copy_remote_vm_str()?

--
Thanks,
-Anastasios
