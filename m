Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285665;
	b=sdKWM839K9BfGor1mCl8HSMvckNmKgh+Oo3XbFqpd7+OgEVZrFL7R1tFkyjPtn9//cdJ
	 5EId/dNvohp839aBld0/8HjWv/VqW6DlYAM9N8jyWzxwbbnVZxeqqcL1Np6pJ46gXGdEH
	 EIBbZ29I3yLstvDpqN3+fmrP6EhqZS/1DmxCuuWBNI3U+oii5AgDRMJK2EdbND++2CO86
	 9k5fCkUzM87LKdWqHQi20aOfKgsJAjP4RQjn3yIfM59n8O3izMM8v8aam6wC49gL6SlZ2
	 68Wx6YX30gl/bfy8hNpUqBopSWhFZxgHwo4j6ZYsRF3CGJNN39VdNRUuFU3f5AWEqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A2IquiPKClvkTsJZo5KHXsqR+OsKvLJ31mZtX/9MM+0=;
	b=IFh+V1JOYMBAxFac9+LSbDYE8Pn+gZaazSiGERyy6fZNGuLF4V8QpUuR7KvTwVC8uSiI
	 B9ZtTF9Hcxq4XaXdy5qzUOtwjZp0nduFx6ZHLetcWuqTzCz5j0YtvQ1otMDD12N9fb4sW
	 l9/hAAe/Ic+S8aDpNITQaoUkxbORxiAkxsT4hMf18Ok90BZNO99O7vs+lDAh03mog25fU
	 N0kaztmvDzj/TEYb0ovIfmL+h9T0wpbO3IWGthNpEuIjnN8m69SSr9m0EqfpVsPfdqr8M
	 2omqzC/+uG2akYSdz1mM+d6c5hzDZkCS95K/AcvmPP/YhEfhi78rZptx2NVjHPdbX5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXUPGsQL;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B76606A330
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 18:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B76606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXUPGsQL
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a3ac4ac65bso78840f8f.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285663; x=1795890463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2IquiPKClvkTsJZo5KHXsqR+OsKvLJ31mZtX/9MM+0=;
        b=zXUPGsQLwEGN+zZGgQ9AjMgexb5EbRMM7gpPxJDdobyNUS9iZUN8Y6df7qz0H/enee
         3ctFakO8DuPpa4olem5aEcHDy5tiXtIqRlvedpEFh4EYARvvHUS6rpLYqSCReB33iCYX
         MW6CfgOn//FkYORRt+7zqN92XcOhaHIW8Mpp6RAQmUPOgJ3RqyDgzpzITQGb7U6bCIRs
         1TPtoujMNEMP0grI7TvSvT96s0We++NnfDI4HQ92oLQEfo6sztp0uAWjLEObFUc/WV2g
         W7YdhrpI9uD9ooGQLISmiiQM9U5XT+Fmyf5JlOKFpmHP7zdAVWGPJ8t8TsvOMb+FE/QN
         V+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285663; x=1795890463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2IquiPKClvkTsJZo5KHXsqR+OsKvLJ31mZtX/9MM+0=;
        b=QHLruFDtsSQo19Y/b+Gl1ZtTvxlctakzvRupfHuMZqDgPZSbKnWFu6tSvGdaM9ymrU
         M6ePvfLhl3kBCdHUlp+ej9RQk8iyK21UKrtwhorP0Fw9PV5uV8lkbOqurQRF4vsLfOfw
         lwntDCyCqg9IIP2ntx3iJW7XQ1OvuCeULDy3JGXbkWmzxqwiPU+r1fce4MDAyemcx6pe
         4VodmquxR092ZFdpnSUB70ryuOEj6bphQvR0tItepBS54DucMaZmU+LZS/qGqZ3uUmgx
         z93ctgV9XExtng4Lm9rIoKKpXgiFF/I0RW2mWl3z5lKz6eNk1koYKUR5dMCUKCkeVp+0
         O1EA==
X-Forwarded-Encrypted: i=1; AL+hErEvysxSfp1PsAGma5hKnNyRTHdOfVTGnHMDprEc/3HPxST6GAqFIGqJuDdHMC/NFPerEkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HwRvSJbKUMqPFyUp+IW+D8HeuTOExXhXthkyA20ZqEzJxAYCI
	gEpXi2DhF3WSUsI3PBLiUolzMa4PsPpgIgsC9vnuqvm02FTz4zQZwq4+
X-Gm-Gg: AZFdTZfs3izVEDX+7GcosDhiuXUBP+ITfUgfiOAe3fnk2TzdAgdmMp1b9W+h/fVgVOb
	+H4txWa5LKVtXzTYc8APtGv6/TC/XUvvSGszpZpGYsH3xb0qGG4wkpBIAmzxbPwVZwO/dmvMzQs
	clUILIyYpRQ2whxcSx5NHSVAMVO55+qFjBzTq/HXCQ/i4IgrSPRjp+C3iqLh99hpIwQhD9/7vw4
	munKKzdOYArdpwEpv+uQuS2HM4a6dnTbPIc51/S81GTPyozp05qqczuYP+g2QToUACqFLAsVJmU
	QxGp4GaCpCHj5YrUmO/fx34gvxr4phOSfgzlzXhwVrCMpFVrWz/C4nfaC4ClbwVKNxcM/xvPOn+
	YaezQ9/yObV0nlG9HPa6UD2UiQBkAwRUfrOEug+ZsHMIrhMEyQ7ND0qF4MKpRmBO31O+9vyXipR
	yzcIqGVQfAy0erZhRpYDYujTwG84QzscGnB9azzYPeuLucjKZMukONqES7hoAsW3AtApnIC0OZq
	Mf1fD9TJZJe91/87z4x4BOPPkX8XvqrM0aShy63oiFtrljITUp96Dbx3IytVLZvw0Xj0qlOsqTq
	XUjoNONclCcPgEmcTuM6FY1ve8ol7ajZuXlWQLJdC/keE2nVhd9wwunmvd8pRp3JhDPQqA==
X-Received: by 2002:a05:6000:2505:b0:492:3672:eea5 with SMTP id ffacd0b85a97d-4ababda5370mr15300169f8f.2.1795285662799;
        Sat, 21 Nov 2026 10:27:42 -0800 (PST)
Received: from Nuel20.localdomain ([102.90.87.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm14215507f8f.24.2026.11.21.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:27:42 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: tianyi@cloudflare.com,
	hangbin.liu@linux.dev
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH net-next v5 2/3] selftests: net: veth: propagate channel-check failures to exit status
Date: Sat, 21 Nov 2026 19:22:16 +0100
Message-ID: <20261121182217.4609-3-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121182217.4609-1-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com>
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

chk_channels() reports mismatches with a "fail" line but never sets
ret, so the script exits 0 even when channel counts are wrong. Every
other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
sets ret=1 on failure, and all chk_channels() call sites expect the
check to pass. Set ret=1 on mismatch.

Tested-by: Tianyi Gao <tianyi@cloudflare.com>
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 22246278e6049..7a2bbed0263e7 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -130,6 +130,7 @@ chk_channels() {
 		echo " ok "
 	else
 		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
+		ret=1
 	fi
 }
 
-- 
2.43.0

