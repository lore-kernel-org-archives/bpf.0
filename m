Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BD332607
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173097; cv=none; b=YHsQ1bwsgoTnDzSo9MrhQItl6c78M+eBAIWu90xiMfFZUn2P9SFkYsEv+igpEhBcDiolt7dmhPS0roxFcAHtIacEN6hib2eRxiDLLyD1Uk4PX3dMqIRYKFp36QfZ3+kZp725ekiBZD32HEwW+eMerAYa8K5AiiL3lsnQnIX3j0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173097; c=relaxed/simple;
	bh=xtaqGgz0rQ0tjyH/ErNTLu71rauDdX001OKKvtvPx3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuAtVOV+TNfeG4XKpBwajfk2BCzKyG92qNYTXjv4DoR3r3Iwd3TMFZgbA1DUXwrI3AU/+4EWg/uGoLyGjLg1+ZuNWuKerYDnnE3RKJl2V8I+FYyrejYN3XJOcxksQmhS8jnD8ECer3AwndQYFLkaX1g3mT29BTTzCntGRLbZy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS8gjwFv; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS8gjwFv"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4398e850783so1117680f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173094; x=1772777894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GVtvXm72TcUE0O6MwBEwQ8fveVVC9XHCdQUSyyFzWA=;
        b=WS8gjwFv+Vbo7UBTYU4CZzL+togzau8fbR1qu68l4wAGuIycbg28JlZe3DtcsMwfdd
         8hj8+/9JTrgXPPMF0hkJRYThrE5FkdCPmpSLGflb5mWwQWK6p8X7LTjdCJ9m4vkJypOQ
         MNd96V5UgFRQ018JTeJ6CxIYboywC0v87Yui84p4Fl6WOHEF1J4643IqNxWzxE97e4nV
         g/ybFjkUoIDH1Jz+4IS3H9YSry1B5i3XZXJ+IaQbg3SNb9Hz/w3wldMU0o4il3e7RGR1
         EUCkdYlj0Gz9B45TSfURkbXdTiVo/RcQRF0swSKJpFIYLXB1naRG8bh6mUtoL6G2GLnJ
         lo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173094; x=1772777894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GVtvXm72TcUE0O6MwBEwQ8fveVVC9XHCdQUSyyFzWA=;
        b=gL4SPj/aT4spCah+FbSJWHsaWNImSEyQB0IBy7ERYzXhV61LJJQNfL1GMythckwO1W
         /w3PTkQs0ptyvTL4ZWQDP8LSxp8R1SRlih1Vq7f6LTmah+I89c4pr3crY5EdJddBRxp9
         byffoaymcqBD2D9/gCiov56kLEogY7SAshKzJ7KHLFu5Es7GMsSU5LNHqxsjch/KazeI
         VjpBp7m6qr3BWiOMrxy7AChgm1nbvjWiMZMrsDUF4WVRLLWoszxF9xXy4gT1gBywHNrz
         0DFRis+xH4PglLjnFE6SBj1rJQDKIDWfC7HjuhRSZgcZhajJ44iLIRYKBSFEufL+M1qn
         cK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR2aTUM6TxAyrhIcyktcIUw6FZOleQX4qeNgWpKmhCb9J8gYEULPcE96QUNuCcojFWpsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsiU7CcyY39OPDLYX1SjLKiqy/I0uPTRNggZUMPTbmY9D2qgb
	Em5o5Smh+jsPdJZJtvYAk11T98VJLquVR2iv32FdupBWIy1Xsu/TCDay
X-Gm-Gg: ATEYQzwkmQ2XTS8VM0GxtFC/didspoE70fLPVv04AXHo3dFNRxSqJTVF2yH5t4GKATq
	nRkxwqbraHfJw9E/WzKBKXpn2F2W6HOWGgXJOlF3VC6G/jqELF6EIcQZozsfdqvIQ2hrqTyZa15
	4ped7NTnrys9PoZ8WXHT73XToEo+Wa5iZ6kHIP4z1GZsq9yUSvU6jA55Wl8Cr5N84w69UpMoomJ
	IWwUWR4c23isnaQ+5eLBf2h5FzD0spMlSMyVKuAWR3cxbXS3kY50h3qMJewO1t4Q4erJUT+c6cz
	zLdAELFMXTmtG4p1ZKyrt1/XS5czDNxQ/IY2z5x8qvQ+L/JFm0MArZ5SNJHGPXh+6Um4ZTITQj9
	FIj6gtlaQo1t6zXPFZq2uf3t9HgGfcwPV2Jtln1z03xRVzF2MuKkwdNaDdtFsE5rMfCzDQerp/i
	XTPsQlSbKMIgyvk+zxDVECn0THKGT8vRoRRed1YPe44knBZnKfJA==
X-Received: by 2002:a05:6000:601:b0:436:1934:d234 with SMTP id ffacd0b85a97d-4399dde5f46mr2389104f8f.3.1772173093487;
        Thu, 26 Feb 2026 22:18:13 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c71b498sm4523755f8f.15.2026.02.26.22.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:18:12 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Fri, 27 Feb 2026 14:17:59 +0800
Message-Id: <20260227061759.1126681-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
References: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d14fb6d0ed0..f7a0116c7e46 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
