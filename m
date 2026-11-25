Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577419;
	b=LlEEuI+MvDtsyL3KpheGDF9tDUZSb1tgTlFjd4C3EcIqMuTN11cv/5zD9irhzSxDhpJh
	 Wx+IPlOzOKXLItUxjYhlKkr+LukgHEiG2PUWBp59CaZorLJXDmC5xyuEMA6N+STpWiMU9
	 qynUV4FSqL/BEFWkQ2+OS4hupIxVFbHz7xxmLWH6ka0qO3Ta2/p6Nvouh3DZRAKSwEh1O
	 piD5NrizyV65CKGdE77DtcHCTnfNAdJT+OjKEGF3DvEX/+MZ/ZeKauvQ834jeVjsLXxfm
	 3quGfeJB02xwgAXbQmGA5mVzu3EteO1t6OGqiDBbAboDpL1oXzRSoVaY4F6vlTbA2ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m6G9XuMlNhAhf3b0eWoR8J9oAL/vGWAXV9eOWW5NC4o=;
	b=HqmljP6YWb8VSV6zNRG68fohWNI7MFkMXaG9/JPqggztbtXhx9+ONqtvuJDC5NRDJPNc
	 Gm6/9Ed5cNEptBaO+KxKS/uVGZzrhM8n4mzN8OJVte4qde9FSp/muzzbyx9968bPBM5by
	 RJmnS9TYoPxwPoDeKplzYwT35EWJyGPXTJV8JmxgiZrniwL2xlmDCl9jr77vTAe2gBmq8
	 RWZYSMq6IhUcGXgdyaaEREzU5WfgXVZvy4IbI9eJYGrFgTmBRwtSAINurSlxt3UCIoMoT
	 qxb3qPXYv23eDCbwD0Jgja/rxd10/LakMIY9345Hv+FdgizebUTuEcmY+32AyYLabww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DL6kbZiv;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B08606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B08606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DL6kbZiv
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb9f760337so3101209a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577419; x=1796182219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6G9XuMlNhAhf3b0eWoR8J9oAL/vGWAXV9eOWW5NC4o=;
        b=DL6kbZivDVPFrjtZNDldpEhdKkt6zNpkCgOWDpCSIx2dHeLxXbft6sixHwxZ0YT5Oa
         PYgPDyzSAOEGdC2T3sUWO1HhWyGXbHaOCAyqtXS+q6zELbWZRnTXkyUlP0Gr30Aqwo87
         j66faWzUprlsvuwXPA3lny/zw/7GaSAKzA5EwFkjS0dYWzHCsGj4UgSUc1EYGt7T8OWz
         n2Yf26NgNDX/G3kCpKBt8A7WfNcK/gyPYGNdq53KpqU1Ghy3QIDWEv5kIymf7b/Oam6T
         HoIiev3crvEHnhUzTiut1iWPSjkTqs9jBZwVSkDFKLP5KI3/VHeCFGr6MAaJrcF35m1A
         M66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577419; x=1796182219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6G9XuMlNhAhf3b0eWoR8J9oAL/vGWAXV9eOWW5NC4o=;
        b=i3iKNZ0CpU1SuW4audeYE1izIUQpSij76xK8TkjepTsRwBIOHhyfsGrCZisSWQuhIY
         gZSwtTaMerLVv4jpOk2UlR75lRBNR2JWkWQzUssx7igXWID3dJ0E9sPXT7vmu6wy+Px+
         8cubyA+1Seen1UUAozn/fR01SRseDnSKw7zvVD//LrTDRhXOh2XricOG8rBa2jkT6mUb
         AlyEsXI47j1xuizZJeQJFd0b+N1alwKPrc4rxkS204hT6AasYCTRDZUxrzJnalCvn6T4
         uMsQlTvFprqCMegkCeO5goDvNKItRo8b998nhTDamvNzVSrjAFrAJ9molNyJaAbOOnQa
         8Z/w==
X-Gm-Message-State: APuU4Z9zdpDGz7dSQLi+mLZuLPgHqpoViqnUJWDVpqjolmvp+R66NARZ
	zTA5ugy16cPDZDp6bwF+KxwUepqPtWNa4+SGTNlybh21GCTmd8DYQneLCjkdrAju
X-Gm-Gg: AZFdTZdq9qHk7dqeDDOCYLqMAjgrT1Wl1CHei+BEoVwUT+7QUxf5OBRwI7GEwM3GIvJ
	4JWzzKXfXM7PoJePv2HEZ555uiwwReYFwK/JRCfCAmjUlqzY3TT1mFq5mm6KoRxxD8qeqXCM8oO
	qM0jKwm5alE25ToCDAhYzRf3mjctUp5SzsaS/NOY/R2SywR/oO99MLbP4c4exzmD7A+087gNwik
	Ng7U95jyF9unNvHuyZKpkH1+5nNrFZtKSnaZPLWjjsU9Zg404/1YqSF2IXqGjtcrSTO8xvL9PdV
	mlw/10da2uxNTfMlgFg/r2QjKAiBZdRbiEkgrWQYJMjoRhbiwvfCH1isCfncYAwWny4eNhgIJvI
	E4AJ4GCrlcsu44k4xclY6F0v2yLrD3ky7RfdvrnewA7qzWXvpWYNf2Cjcca2OIaNkTTrN6DHS6K
	cPSPGB4qayfeKo57bGcsqk63GLFwOAvVCGVdn1WDeb9e6YtWwjfmIPlBSIFfJeOXnFZl8oAN++F
	PvK1doSCfnHchdqIRm+7pZ15UzCxb2tM/FNO7KCwbxa4pIIQb2IpHmIVIaEHP4U6p8geyd1hNOo
	fmDFLSDtPVYuIRUFRgADUBBArXE7MTMsQQkYQvpEnBR6CAKYsNmC5BJ5SSv6SPby9+zdnjMq2B1
	v7BfDSm3Uj8iQ5uMCKEB+lV96BZI4dEs7fFUfITNyxADaf7tcPbX2vTsCsWc+OT7QRLOq3tpTg2
	j+H4Hr/XeKIvDvXg0vTY4=
X-Received: by 2002:a17:90a:e7c2:b0:3b4:f983:e52b with SMTP id 98e67ed59e1d1-3b4f983e5f7mr480958a91.5.1795577418012;
        Tue, 24 Nov 2026 19:30:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm27939054a91.6.2026.11.24.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 06/47] bpf: Take the attach type of the target for tail calls of an extension
Date: Wed, 25 Nov 2026 03:28:57 +0000
Message-ID: <20261125032938.670542-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A prog array compares expected_attach_type. It is 0 for an extension at
the time of the check, so the extension can call programs that were
checked for another attach type, and cannot share an array with its
target. Take the attach type of the target.

Fixes: 4540aed51b12 ("bpf: Enforce expected_attach_type for tailcall compatibility")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0bfd23a41401..14b8ee05e506 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2518,6 +2518,7 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				      const struct bpf_prog *fp)
 {
+	enum bpf_attach_type attach_type = fp->expected_attach_type;
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	struct bpf_prog_aux *aux = fp->aux;
 	enum bpf_cgroup_storage_type i;
@@ -2527,6 +2528,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 	if (fp->kprobe_override)
 		return ret;
 
+	if (fp->type == BPF_PROG_TYPE_EXT)
+		attach_type = aux->saved_dst_attach_type;
+
 	spin_lock(&map->owner_lock);
 	/* There's no owner yet where we could check for compatibility. */
 	if (!map->owner) {
@@ -2537,7 +2541,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
 		map->owner->sleepable = fp->sleepable;
-		map->owner->expected_attach_type = fp->expected_attach_type;
+		map->owner->expected_attach_type = attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
 			map->owner->storage_cookie[i] =
@@ -2552,7 +2556,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		      map->owner->sleepable == fp->sleepable;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
-		    map->owner->expected_attach_type != fp->expected_attach_type)
+		    map->owner->expected_attach_type != attach_type)
 			ret = false;
 		for_each_cgroup_storage_type(i) {
 			if (!ret)
-- 
2.55.0

