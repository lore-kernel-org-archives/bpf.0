Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018603;
	b=FNVTmtO/zOyoezbIeBKUisfxplM9EF8AMVduAx/mnTD3nks8uhKLc5vURoqc+v4bnA9P
	 O1z6paoE+9JPLaWgimE7S9VnRUmdWvlmLfrndqeY0iinFgIvNXXOAuvzelokWvpTvsFjz
	 7scYwg8fHgJbBii/WJklFANK1XaWjWVSla+BACPxGkE4LLpzR1MfNfby0STL2XJHc91L1
	 sBmewdTJjjDQ9eMxdZ14fCvvZvsmzr6kgtkOJqm5BWvr7JF6XkJC+RchpHYG9tpDCkli/
	 1Jt+7ZdW57CjWfjOoVDfC2F8epTCslkwORK0u0LkN66rlPiOnoHq/YNQgVGQkPXq6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+hDJ59DAiZ9oaoQ4Kn0wejktfUDrr5uda88bBbLHEsg=;
	b=F3erLHoTr+8xU7pbnlG/mXfvxTcapsurWrulzdaVB/7ycdkH5xphERBDxw+5jGWSlWM3
	 CncR6Ud8PpJy/SD9pXuaQS/ctfB3Kv1YNb4o1zjeRE3p/k70IbDsC2njmiLkjOkpwnuHT
	 pxrlhmhsJldu1XKLWP7GgLcmrpAGnAE+yHg0xIjCbIjiK5DA7jjhOzMCpZniCj+NeWOXQ
	 8HqbzVxKt46KbLSSZiIuyjoc9OARFhnu0LW1I4opodYIOO+JkwI50BDVWcUaANQi7V2Ya
	 4kyrSIr/RvKalvwf+waV86rHCAyrFgB3r9IozTdlYhLR51bGXshvcn/G1fvdfbYYbhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccxItMpV;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA8606A32C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2FA8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccxItMpV
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3bbd46625so316155a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795018602; x=1795623402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hDJ59DAiZ9oaoQ4Kn0wejktfUDrr5uda88bBbLHEsg=;
        b=ccxItMpV0dtW5594Xn7TJbW87gSKf4IvHD9fjpkuHCHYo8sZ/oVnH4fgzRiCpDDbrV
         /qu2j6GRtqKMMYYSVqZgLlnwtnE+hO9y3ml5GKeMO98wh3avt47mhDK/7ukjdRhAo+qg
         TiEwsEiLIzhHrzksmEUFCSShU4FPRZw1Gr6NNwIf9oZfrSp/6znwyk+yMTqemulec254
         FGyuIfPUopBor+IUXqEWzuhNjfBro1d43eQCqesDB2lwxGw4HwMDy1dI0b3AOlk0nnoS
         ysF9iGijvW/kquY0gJ4vSMxDPvH++EQo498pEwftCrC6Eu1mS+drpV7+DM9P4tY9b1q6
         M/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018602; x=1795623402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hDJ59DAiZ9oaoQ4Kn0wejktfUDrr5uda88bBbLHEsg=;
        b=xxV0Ex1isl79xHTcK4HVDpjNQAxIekIURVY/KDinP/YNk68gnvKWxyAwi9Je1V6Rcr
         2eNhioLHq2cF1qg47mXKjPT3jBe6qrzBcaYnvzLXddyPutKR5JYMyfWp3mUeNFCc2ity
         ma+gT1POWlqRRfuXK9/F+hD81gxAMMxAp1U5Arbbj6MBPxG4nXIS9X9ZxG2ZSBCLpRdG
         x0c6gDQUSqT08uqNmlMg7QvxEDYPqyQocsNk0BxD5DcHDVPiQqTCUKOe6nn17o4mHGFL
         Afbj1XpdgHE5r2PNeVD9xpKREbb99WHpr9wPFKaBj0aRyVHk7N2QS1WIllLp6QY8QZGJ
         ev2A==
X-Gm-Message-State: APuU4Z/0GigzN7aHEmTQk6d00R1OF/EpbLoaaBsDlCnuhYUberEJc/g+
	Fxv7Z2sd1Lk5vWhJ16sl7qK24gcgySzm3AytNMn4MuIN8EO5w3jM7B9fPYSz5ivVYH5k7w==
X-Gm-Gg: AZFdTZeM4kMz9Bb8zxPpC6xixrxhggHigQdTChDtO2LmROi3TcvmG/7tCth0vQnIuSm
	f57eJPyLs92WSXpTsxjDgi4+Nu8N36oX9rljc1EbcQk7cdRkG2he+IN1TFvoHL6VdFhYJ0Nf2lX
	2aBDPGS4VZ9CakpoA6tHw0aOek4ReNyh7aVpKg7zk+tQQjCYz2/2tlf5k1Lnv98OK5kx8wYzqkC
	o80GvqaGAkCmS8bqdpAYkceYHyRIitrb94Ixj5/UvITJ0uF2JcG+UcHWlPQVS1LIHUmuLfAqt1w
	2ERHbOLzBeHN8fgCklxGSd/bQA4BTdVuTD0SeWymaMH1WhGMZ9/CB99i92JTcl0aPAmBrvNpDy3
	aNhoagCDb1Ot79p6ySLJEL4w0q35dxBZBLwinloroePLfdaELNhe87HlzTBUURZW4DmYI5oppZm
	ofu5CHGP1Yl9uz5AHQe6VWAbvvyZUkp12RQG8yCXFmATAaHJPY4EXzDIubuVF/n6ArMh39wSU7L
	TL4af4xYUb5/X7grBsIUeMMD4ji2wZrXkegCXgf6ornE7sFGCVWSfDRE7znGGynkhhKw6m/tZGP
	RzOTpJuhyiWWUnWGjU3aCKZod5gtX6mUiCyoLhvMkzHVW8o=
X-Received: by 2002:a17:90b:5390:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b3d0640f3bmr3428395a91.6.1795018601880;
        Wed, 18 Nov 2026 08:16:41 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde533658e4sm256978a12.2.2026.11.18.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:16:41 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	qmo@kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Reject offloaded maps as map-in-map inner maps
Date: Thu, 19 Nov 2026 00:16:31 +0800
Message-ID: <20261118161632.177820-1-shlomojune6@gmail.com>
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

Offloaded ARRAY/HASH maps share map_type with the software maps but use
bpf_map_offload_ops and a different object layout.  bpf_map_meta_equal()
compares map_type, key/value size, flags and the btf record only, so an
offloaded map can be inserted into an outer map created from a software
template.  The verifier and JIT then use the software layout on the
offloaded object: an ARRAY lookup writes to bpf_offloaded_map.dev_priv
and a HASH lookup reads bpf_htab fields past the 320-byte allocation.
An offloaded map used as inner_map_fd is accepted too and leads to a
NULL map_lookup_elem call.

Drop map_meta_equal from bpf_map_offload_ops so the existing check
rejects offloaded templates, and compare ops in bpf_map_meta_equal() so
an offloaded candidate no longer matches a software template.

Fixes: a38845729ea398 ("bpf: offload: add map offload infrastructure")
Link: https://lore.kernel.org/all/20261112105620.57520-1-shlomojune6@gmail.com/
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/map_in_map.c | 7 ++++---
 kernel/bpf/syscall.c    | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0fa3f2ac0f992f..9ec3bbfb5d4e3c 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -38,6 +38,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	if (!inner_map_meta)
 		return ERR_PTR(-ENOMEM);
 
+	inner_map_meta->ops = inner_map->ops;
 	inner_map_meta->map_type = inner_map->map_type;
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
@@ -65,7 +66,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	}
 
 	/* Misc members not needed in bpf_map_meta_equal() check. */
-	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops) {
 		struct bpf_array *inner_array_meta =
 			container_of(inner_map_meta, struct bpf_array, map);
@@ -88,8 +88,9 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1)
 {
-	/* No need to compare ops because it is covered by map_type */
-	return meta0->map_type == meta1->map_type &&
+	/* An offloaded map has the map_type of a host map and its own ops */
+	return meta0->ops == meta1->ops &&
+		meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 60c4d84b9aba6f..0cae12c3f70849 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -112,7 +112,6 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 }
 
 const struct bpf_map_ops bpf_map_offload_ops = {
-	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = bpf_map_offload_map_alloc,
 	.map_free = bpf_map_offload_map_free,
 	.map_check_btf = map_check_no_btf,
-- 
2.43.0

