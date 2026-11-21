Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285611;
	b=bcYZ18Ia4k2trKELLFeDSBgz7NzmJ9vqNpKKlg67rlK+gBeWNTI9ymNxtjix5GRCWQGU
	 8hAfav3VxXagx2/C0A98TO/Sw6BHiUEq3MCi3E8WvrPY1l5RQnC3ekxJ17dJIwX6OfWxc
	 /HzM6Ry/E9VMcpen8fOY48XvSxs8XffCYPN0onSzNTdsBJzwmTn9OA41oUj2HLUCvJU9F
	 64Lu1G69Ir2hcSl9+53OxSCyk/h+SGsX4bDGYLNKxUBOfv3K19JAn+xRcGzjEQrQCdH/u
	 h5tKBlxBKmy4fMXwhtkAZjdsR1TULgAMvIsrt+7CvWEOuVuqsjxl9zD3RCCP3TSpT8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pdXXKv//+YLQIm6mnt0NYSwAhGN57SfFKoOM0+stirY=;
	b=YSACl2p3AJTNoPQ2TU9yZ2TTxVYPBmwL66PMONJu0RxgXlHbJi1SFTsZaGz+by/aazDi
	 DLyrmvuBIrfXj4xBkTHvvmvCLr/J8Honyze+GZiWA5VA0dGWDoahcW+DaWvUFw4silIb9
	 8pLJ24akROTaScI8UJUO4JCEy47HWf1wH0RQPdg6Gi2oViHepKovsN3kY1xUowe5E3/fX
	 WTAe0N7/GtUiu/5VNlsf9YzbRNMfLSn7a86M3d8VEwPhnEH6GqjX3LSmmz/Gy0AanOjKj
	 kxCGi7jtTm9A4P3/3ZT0yFA7vXfDG1WQb+jIyBwlgfVlng+5MlR7R66FpD44Z6z9xXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKvVJIJ3;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A31606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 18:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A31606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKvVJIJ3
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so1584525e9.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285609; x=1795890409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdXXKv//+YLQIm6mnt0NYSwAhGN57SfFKoOM0+stirY=;
        b=fKvVJIJ3xbhMBJPHM5lDunHvwr/SsXQmTjyx6iydI08yXI/VFQAys1nPxfXh2/vKId
         /j+pNTygWGLlZbjeaO8Yq02y6RA1fZ02FPFjhA3564s4/koTy8ZvpVZo6uUqgoytzELk
         2ZC3WjtzjDSklWaf0cSW0ELGxJ0Kcf60hxCEJn1ZuxzlGjGZYwhTf5i/4c27bl6e7JLs
         S0AUM7oLy+k0khZvIAu3zCW9H2YhrvOATfEyLUddeVsUB2kBLVROU1D0epJCMUoAsBgc
         2dXeSUGNqUJ7Nc2tXt1cBJdPbHgiTAlX7jMa+ANtAOQk09A0bHT6c1S2HkKmMzjhcE/N
         x/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285609; x=1795890409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdXXKv//+YLQIm6mnt0NYSwAhGN57SfFKoOM0+stirY=;
        b=rczvEXKXoO12WDl2oJoaG1OYrbNw1+CWO+NFVXvNHgnR3cCnr2JrnqRyor/VUc0V+q
         eDMnsoIn6yedSBow93HgQMyIYLQJgqN/zTSZj+YSWN4aBZt0Z7C8I3X0Y6vd9csnRu+x
         SLpYgrnTxwnUxykOM0FHEOEFemm9O4oYzZn4u7PAkvZtkkm7HUkG5sIr2LuIRI3H7hCa
         5A6wHlJ/+nhAOHC8H8uDOQXBaYsxbCECUsSC7kWH30/7bGXYSesmqwJf+Z4JSVuDBYl0
         ktYHyXav8TOyRYrjOltVrjMD9aSEzcgDWlSfbzpz2IZT4I6kpJSc6TSpVaQwoC5I2eiA
         uaJw==
X-Forwarded-Encrypted: i=1; AL+hErEFo7b+hu4cO6ar+M0nk+zfjA2U4bawU8P/wNiqCc4B8rjbWUsJQ7jJ6fCuoEGFWBZyZ2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jxWPiTO7+kfgE4mDIK95o5ukYGtgtPRBZfXwmnIRdAiUG5Nsl
	aGstTNqairH6ewECmTk2uQe3LUzS8YOeCvMLmbUkMdtKESChR2cRgElV
X-Gm-Gg: AZFdTZeD5ru25x0nXtT+CuzZIC3vXnvzaQNbNIGm6NAzGTdyfAeSIErrrFQ60XEuowp
	IkbJukm3dtK4SPhyzenbyAvR4ZqrG0m1DMiADuYPPk7YGHYF3dJv1vy4tOllK+ZkiagcTr7zlt0
	81wGMINXDVjDtLkpt6T9CEmbmVCPgj4v4hmI8PaY79TVa7zidCEPghHF1k0pzLjJq54aU67yK1Z
	9KAm0j9OCfsmYyDovSG91zNvWqTpo0sS3pMjY8k7wttqI7HloYlLiP7yLcmgr7//IqHaOKPtKa5
	ipLkzlchDQAWHVfdMGwZ7mn3HYXmMJDhxLzekzhp7J500fV0JerzWDOgDtHG3WZYgF5w/RCjz4+
	wasLN0BrzXW2JAe7XxN1+Fq8381dAbJl6wI3nKFUpULrzMr+qKPJ8lgZvWsDX7DBI/flZjmLbLr
	kjPxcSWLA+bNiNVvhXVoO9XN7bS228Khj3R6w+gtyI1P+Db/bwuaby66bgAWwd1xW+ekpNyptB5
	2G25w3g0f3iUNzLQBf3oitvHbUrb/OlB+RrY7GD7DFRTZKOLT75pkixcXnwC8Rf1fpfhWdACfF7
	Epu+YrDEHL+z3/eWcaE5TnrZvzyz3ydY/pvybuDteHluVGgAB2/G/ME/UWoiFwnJiYdAVA==
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr143498125e9.0.1795285609454;
        Sat, 21 Nov 2026 10:26:49 -0800 (PST)
Received: from Nuel20.localdomain ([102.90.87.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm14215507f8f.24.2026.11.21.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:26:48 -0800 (PST)
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
Subject: [PATCH net-next v5 1/3] selftests: net: veth: derive invalid-tx test value from kernel max
Date: Sat, 21 Nov 2026 19:22:15 +0100
Message-ID: <20261121182217.4609-2-emmaonana18@gmail.com>
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

The "setting invalid channels nr" check treats CPUS+1 (CPUS=`nproc`)
as an invalid tx count, but the kernel allows up to max_tx, for veth
that is num_possible_cpus(). On hosts where nproc < num_possible_cpus
(taskset/cpuset confinement, QEMU maxcpus slots, hotplug firmware),
the ethtool -L call succeeds and chk_channels() reports a false
failure. With failure propagation fixed, this fails the whole script.

Query the kernel-reported maximum with ethtool -l (the same parsing
idiom chk_channels() uses, first match) and attempt max+1, which is
invalid on every host.

Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 64c2a5a59821d..22246278e6049 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -463,7 +463,9 @@ fi
 ip netns exec $NS_DST ethtool -L veth$DST combined 2 2>/dev/null
 chk_channels "bad setting: combined channels" $DST $CUR_RX $CUR_TX
 
-ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
+MAX_TX=`ip netns exec $NS_DST ethtool -l veth$DST |\
+	grep TX: | head -n 1 | awk '{print $2}'`
+ip netns exec $NS_DST ethtool -L veth$DST tx $((MAX_TX + 1)) 2>/dev/null
 chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX
 
 if [ $CPUS -gt 1 ]; then
-- 
2.43.0

