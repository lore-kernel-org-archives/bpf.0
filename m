Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD727E045
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235703; cv=none; b=M01Dkr9wV5HN9baKBlwVuq9d7KRxTd2EwVrUgSB71FVZIXERHvqGiNB7wRC8JRtG2vqbwl7/xSY+wBdGacAuxhTFX6sMiFxbkimfkm5KcBgbV9Ivug48Q16iLH8UV9Njv2cqrdx6ucZ2FB6RpYS8sQaibCAsR6/vt+v+lIv06/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235703; c=relaxed/simple;
	bh=pPH6IGYSvT73W3XnsSk5F+V+bv692q4Zq0EDWpqk/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUQ6jm6+hpTkZsoa8YypDIXJej86/UNyqKWNp+LS4b2/bJESsW6YysmiKIHkKREfFhZZG1RVVCSX/DSKVqgmVrYQrzKUZGxmIcO2po3GB4T1Z2PIqKz8HrmWD1Vx8AGOw2SpbSN9hEWw2+BqJBEpLpBDTOXQeUD6n19VpoC7CgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgq9l1Ke; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgq9l1Ke"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso2176897a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235702; x=1769840502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=Qgq9l1KepU6Pr+fN6DOapGGkD5H3M03fk/XunYGs35TvqsfzesnMVTvUsii9Uygbhb
         1zPx5aptuRjIMlwKo75iYH5wth1y4jQewQxE5/AX4I4hpbgrgVzvDNR+xexeOyURUu1Q
         Wl+beT+hTmTuAAtPWq+/g9DUBcDo/2GUUb6N69uD2bJPXx4IxAU6j0Fem6MpyalcM25i
         czISzJNIL3yPZ7ul/J6a5v0D6q8ba+kCgpD7a3T098fM4y2V8WLV5YMtKFt51mlkI+bN
         jfXSmRhRdYxZByiOA3ZZ4dA0mcrtJfdp1vg/T0z8yIW72Zy0vY7bUF1ORk6ahffIuy/l
         vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235702; x=1769840502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=LER+Xfx9z0F4/S61rNp7Jww3QNqNYOxxwPhhTGkuVk/LFPge9FdKDJGIDNm9lm9/mo
         8diE1Ln2pH+8G0JG6hzElH8P92oFiOeQABxfiglFUI6Aku5adcUn+4fcr5roffuNbB5n
         +8R8onwmzTN8/aefMLTAnhUnnmXdN4xROwhFwJsLIxmXgpqQ9n1Wtk6wTzA8RV9gz/N3
         r8gZ7ZV3UnjeTyAXSYTU26trzuEG/Jm/BsR1XgRGkJXj9fD/Opt0ZALPyp6EsvsEXNpp
         FdKbbamjgzUWDLJ1NK90IKWDOC0CU59dQjrs+y5rVDS0zjoqZseNKifgEw7T0t42j/zX
         wFBg==
X-Forwarded-Encrypted: i=1; AJvYcCXS8kHePQaMQyLjOVrCxLBSz3w2MEms7u9/V03bddF8/dXyoDwY2IIlPzQGCUl84Ci3bGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OwZjPpXyfjRxRBmi4wGPIyhKlCiKxXM325Ocn3vtbxWtbPC/
	RuYJ/kNrInHKUExL9qYLJWmEQv7aduHMZxZaK7egh07vP+gcupKQsOvI
X-Gm-Gg: AZuq6aLkHy3HbUkjTvDObKtpXERyZz/JlriqInFj68Cgq2h1BJE4y5KEsZWVg1wJDZb
	+YQj/UeUMvuOBv6nAx+GM8nQi2LKNk4YD+HGgLaCD+PJP1AjvymSvKJ38eGyqHLN9mPHGmGQIpg
	TnsejTIRgKU//i5VYNx/Epm96nCRTjd8Uou9DjuybKlTbxgTkIdsGcr1UAPABeivTrnEep8bX5Q
	+LbepSE9JS0fWtL5IVieAGHRAxVZmY6+Sj79DK77PRGKasIA5tKehdCYfQbgD8waeXah7RQHDhM
	bIworbiJFJToCdXF4B3K1DTFkPLk2rppgeLtUhHYaJsYvb0PcoHpw7NdiX10hp78ZwpQiSg3eEW
	0dh4A6N3NGSOaNIxYP60dIUslbYEz/RqtPtbZFf5QM/cdSwHGlAOccRGr737zD0DKxXdmEhUBkp
	i6QKBsRnUB
X-Received: by 2002:a17:90b:4c0f:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-3536ac3b86cmr4101831a91.5.1769235701779;
        Fri, 23 Jan 2026 22:21:41 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:41 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 09/13] bpftool: add fsession support
Date: Sat, 24 Jan 2026 14:20:04 +0800
Message-ID: <20260124062008.8657-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
-- 
2.52.0

