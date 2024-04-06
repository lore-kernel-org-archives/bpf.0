Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2AF3B18D
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395234; cv=none; b=ppM56kIpTd2TjX+a0izuJpsq6EiBfU6WAeVn3vJpkHOt2qH8PgNBF0TmNfpj8zlqge3qsB+HFQuNpux/dsZk7CtuhjWN8DNDdFo6UbtKPpC7+vzz1whNMdI8m10QiXc/PMv7BlXzTk1q08mNOPXqd/2BT63IvwPq76pM6SGaSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395234; c=relaxed/simple;
	bh=yt9tmTIBJzVdCFZ4PnU57SVH6MzeinR1L4YoDUXNjsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7Mv7/hI6GgNfbyreP0JQ+JlpSyr7GgMd+UNqsK4Qs6hwXnyPZUCBUodYCRrrb97/9zAuXuUTHksUizGFWjPr2UOazDm7VuOiO47MlbyffOVGBbQek+zvZky3cAPVjnSnsLvfKfhVUE8+bxnbEZ0escWzhpie8ZoqSs4VCq6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=J+Zuk4Yy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="J+Zuk4Yy"
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C2ABE3FE51
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395219;
	bh=G6LgQlJD57yHhfXydvKzs8A9bUpRZ0ooDJmyE1zvH0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=J+Zuk4Yy5gSmsqWfBTQzGNBP9MKi6Fwugsk9M6+BxHKQUK9x+2BaGbHHF5Pv/TXU9
	 6hiXNOBU1pB4eVHo3/2LTp9ZzkRDHhpo399gL/7dnjdPG0seXW3H9bO9fsb5xp85WE
	 7fgn3DKNu5xu8WxZLSzLwNO/F4sDp0yzQeDV53xD+o9Vgb9d7mznvTQtwuE0AhGke3
	 cLP4QPjDo9TtPVRJbc70oKmmrZMQYLuVFw38rnzNayNYozuXsgax/ZFQ/OyZR/41Ah
	 HxYyZjIIlER5X4AXDBca/2q7ZdB27fMSW25Uc4cesNYDLTES3hL8PvmrAr755qFwFC
	 VTiVlVJJl7ymg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c94d98afso26915181fa.3
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 02:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395214; x=1713000014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6LgQlJD57yHhfXydvKzs8A9bUpRZ0ooDJmyE1zvH0s=;
        b=Jn2e9/nNMOEGWah2PMuS4q5cYIfznsAjR3COZeEpYvBNhdUzVBmUPE83QCAGui4HgP
         luqVkIq+rWwQI8eQJuUoAyEM5UNlGb6BbbC6HUlRmQzavozU9u9PJ0PFte8wMQYLpBFM
         3rRuERcm9Wu4K3QZlLIyApbFprtvpowme1txq/4xi2mfEYMv3FMjfi1i68dx9krV1TaW
         XtY6V0E/TrIhDjCrD3PB1/k3Bwhd0W1yIE87ggKVlJW0zRaW/nl0CinQCHdd98LWuFzV
         NqaRsxKBazlEIcLfXPcbmizkKXBTIpVfcVxhNY6lEdUiUBjiCf/k36B5v+NIGlK/Ps/A
         u0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnq9afBisiuxVGsyEG0K0K8EcZPFdwmq0eiXapHJfE1BOhrv/IhAk3VJ9uD04WcCk85p8llU67ETP8/+NfJ6O8ThWb
X-Gm-Message-State: AOJu0YxWfdY7Eh39zxHF5WpcTNnJYKKSx3e+gQt7v0tBVOSiuyYjAtsg
	74oCpdrmyTs6mPrJtHSqpkqynqkJNX8Woh9CGaSiyFTVbHaFCcOqWd1RqQt4zipYpf3m1EZnUIT
	6ApHDRm7HbKgw6+rQAf/15pXMiTIz4kwnuZWnaqLfgru5FInZixkPl+yb0ez5IhYCUQ==
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id s25-20020a2e98d9000000b002d6d35178aemr3079649ljj.29.1712395214340;
        Sat, 06 Apr 2024 02:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC5CR3YqSgu+J4/e2RoJd1lpNEBaMZEgCrY3TxjTsm1+4G8Z80bdHexcZXeNzlB0Tjro1Qiw==
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id s25-20020a2e98d9000000b002d6d35178aemr3079628ljj.29.1712395213639;
        Sat, 06 Apr 2024 02:20:13 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:13 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] libbpf: Start v1.5 development cycle
Date: Sat,  6 Apr 2024 11:15:41 +0200
Message-ID: <20240406092005.92399-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump libbpf.map to v1.5.0 to start a new libbpf version cycle.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..5dd81a7b96b5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,3 +416,6 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
+
+LIBBPF_1.5.0 {
+} LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index e783a47da815..d6e5eff967cb 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 4
+#define LIBBPF_MINOR_VERSION 5
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.43.0

