Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698807;
	b=d8mXV7l/epaTZW48UVWpu/aPPoBhg4S2Pvo2wdp7xAL1XmHKnL0KDKXX7splHRzQ1eNE
	 l4b+YeF24+O2JRP3mknZHHwAJH89v9wgrkX6kH9mQkJtMBOGuOTweVs7ZobSAMlL6Xsnj
	 BxAJL2gDiabdfi3OuhTRR/St+VwsSfEeqltH32CM2YsrEmn8LyALTZlVuTSdu/uBX24u4
	 gH80pQQTFA4ABP0+Mt47YGEVpYqaM4iYKYx8oMNF3W/wKL9dPdRI8wXDiAP9BrkvqzfYF
	 JcMLNd9/MMG3LKLdpM2SsZxHM0tjFvtytUX8IOjFN+8Lh58JCQpDGjEFrP/Cn++1Q6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=45M1pglWyzJAfT+SzxQfEEVe/IyIyurkT0fnn9e5xvc=;
	b=cCKJr1qgVlEoPaT9PrcwCW5+ee4zzQSQiTU3/NH/Cs4PQcwK3S8ouDWDOfHhZMbWLdWp
	 xIVwRr2x9BURqvHvKZH31+0vcivn8AIfNZh5ms6XRmvUTfF7YSTghvV0KkLPCb1YlAq0f
	 ux/s05mlAq4JRXAZc7FOfBtEof1vTNuzYeq73G9rJqxu/4McLCkw9WPGMvguh+xzlfDnt
	 N/1uiW9xWy8fq4EUlpsZZsnFsMPvXZ+5NQIOEiULVptHfL+p1NLOr/HPylDeQIz9gahx9
	 P7kNiXVDarbur/a9fVdNowvcJHfulhOWmo6TfSZpRREW3DuNC2fRoq0jS+BbMzHHiQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJyNfUAz;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC7606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CEC7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJyNfUAz
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49465892f7bso5104482f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795698805; x=1796303605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45M1pglWyzJAfT+SzxQfEEVe/IyIyurkT0fnn9e5xvc=;
        b=DJyNfUAzWCoUZaHPCGXoNx2PHzBS1sxXZWwwQ8JxZ6e+pdyeJXAUSqYxV1WEDFHtN+
         jEz7LoSzhwdAPUXI5jfFdsbBdtDtKNgnCrPoYN7aqtpdHBV3Pmj+ZgudAXWUZv7yQ+Ki
         woAqTh0b0XYKbwd4d3K6/ZTBkrTjBnHtg1nxjd+LR1xdu1mj15qnVQG3wnzfYaBgt0m7
         NZwtHdwa6UQ+QHINK9GukPP+cJiLc8xz4FdInsyM7fhPzUgbxsjUxH/HmOt0LgTCTFL/
         bDkYHuP0R4Nw/QvBorzDL33vkfZwk4pDLWhlZHGWI5V9yL3Hbehgoj/GFW5mC7tCKSHb
         J48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698805; x=1796303605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45M1pglWyzJAfT+SzxQfEEVe/IyIyurkT0fnn9e5xvc=;
        b=hNw1QhmBISpV1ABXp4JpNDt4oj3IvGRfNbBpG/7LYVuAzRH5wFtPjpBs9de32Os5fc
         EcSM8iwlxXhpK9cjA12xGpruS44HnWUcIJL1Lig09d1Uxp+fWveI8ATVdMuL829zaTT4
         qSdZg6MgU4y7e6QZog3azweIXJuK9LYlXrgYm/qrLv+Er6hsK6ERKT+TOCePXpJO5xHT
         XnucsrJpiThbOWj/FORb+s43Iozb3UcshDtKaVLyX4xfzsQJA00z2+AqLHC5Wk7Ntdq5
         eTACkcWlmfI1oipXxSYK4LMaU4zVDXB+xzLWuTvhYlLuvfBlv+/3P5t8ca+THAyurJLA
         cwRg==
X-Gm-Message-State: APuU4Z9AxhCITRhe/3YOGwo9zT5zk2nOlDzm+iowBDj7teivLMzjQHmW
	u+JYjRh/lOMGhshff5Bl9yxYGD/kscZKLhT2HcMpOKH/PeFZ21UmM6gclXtdKkZX
X-Gm-Gg: AZFdTZdtdc7OFpLE9oWJ9mZ47msGlRAIBq/IoGmZW80OdxXRfAJnedCiamGCBDRS7ZK
	lw/rHxlmaHtX8xT9tn25LS98dWUjvzkcSadQcoVV6HajgfChFsUVdNH/wN7bolPjRMG26UqUJgY
	QK3ZFntk+2vmH4Yhpkn4Cu9+MmclR5g16eHwY3IIYdStkWMuAdkOrvLccyQsLxKbSUCZ5zozxoN
	MpvAVMGMd0nPSyKUx8fvusMS5ZSYe1NFjx8u/NgjhOh6zAgT/W1ylPA3Xu6k5cPdzlAfqLChe1o
	nmpjgMFtpmf7MDSqpKnvGaYpfxug/sMfOtOLrAc/AsyEowRQcxPRCI4OzlcdLaSpXKP31zIWLYk
	7v32WfAup2haYMpvBBb8OXncOu9ce/Z/wyn8nK9HPGYll4hzlKKWnE0CcwF0zUxMyBd/V72/Hmc
	6KtSgm8VQ9osHFKYbIYgnA4KWcpCTbLzm6oCj5hoV25+O7zF1f1myok+jI+mORFDP3NN+brbIKj
	R/W48C6nadb1KOCetCGm9FuGoXzJQ7r1uHH2jpRwHZDNybTGnEWU/Co/il/2lpfKd9CC32Yb2at
	k3izidcJF8tiQ9+K1/JYB89OoVaRdhMwMfZyM39SplyEMpw9XpLIWSpbNInyZioYq6Wp1CZRcKe
	Fo4uEZW2J2sgQYxLNqpzcog==
X-Received: by 2002:a05:6000:4812:b0:4a9:1b17:4f34 with SMTP id ffacd0b85a97d-4abb57f7036mr38287533f8f.50.1795698805223;
        Thu, 26 Nov 2026 05:13:25 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm41679091f8f.58.2026.11.26.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:13:24 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: account for local storage map elements memory
Date: Thu, 26 Nov 2026 13:13:17 +0000
Message-ID: <20261126131318.470837-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7490b7f1c02e ("bpf, net: bpf_local_storage memory usage")
introduced bpf_local_storage_map_mem_usage() to compute the memory usage
of local storage related maps but left the accounting of the allocated
element aside. For users of these maps, the elements can quickly make up
the majority of the memory usage and make the reported memory usage
quite wrong.

Walk the bucket's list to count the number of elements in the map, note
that concurrent insertions and deletions can make the count imprecise.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b12fcec47ffa..6fb95503441e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -792,11 +792,19 @@ u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_local_storage_map *smap = (struct bpf_local_storage_map *)map;
-	u64 usage = sizeof(*smap);
+	struct bpf_local_storage_elem *selem;
+	u64 nbuckets = 1ULL << smap->bucket_log;
+	u64 nr_elem = 0;
+	u64 i;
+
+	for (i = 0; i < nbuckets; i++) {
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(selem, &smap->buckets[i].list, map_node)
+			nr_elem++;
+		rcu_read_unlock();
+	}

-	/* The dynamically callocated selems are not counted currently. */
-	usage += sizeof(*smap->buckets) * (1ULL << smap->bucket_log);
-	return usage;
+	return sizeof(*smap) + nbuckets * sizeof(*smap->buckets) + nr_elem * smap->elem_size;
 }

 struct bpf_map *
--
2.43.0

