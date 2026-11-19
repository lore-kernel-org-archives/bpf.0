Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048244;
	b=ihgfdVjraeifFXUgwJkuPsmAtcLMppAkfO0LASfV7pp+7p08O2plhB7tKHEAGYPEwoei
	 5wF6AjFuP1Iay99YazV9p/FICW5k9UMxnJLkQLLHO+/Q6kKHk3GmY7XeJ9J+52SQK5ws8
	 anzvr1rg4mLLcfc5dloDSyAlXU1UEV12X7C89+cGMBkSnMBO0GmguHu61rY3mRQ3qGfUB
	 FB2bHeLpg27zlI/Kdy0bHrAHAZbVxu24+pp7JwzzX4aRaG70vI0GYjVQ87tgHA+U3/IbZ
	 +4Y/w3XQbFLxnFLrItZWiTdLzwm3dc4oVnl3nC5TZlmug8LJeDxiF7iMV+cbDsob5hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZiPMStJELJVEfo481tju4B7weEAXXX4fx2HGMzLvMQ8=;
	b=qlN0Zm8jtjs/Ndhdj7N3kLIGoDfjSKiQK7bQ2oYbCeBn/+BmsECmNubn/VJtJ7kydH9f
	 MmKeewo73l/xRvn/G7lGvTCgg5JJKbVzTS8LHbEVKZfuQ60Gz0rEQx8y6NaylEzOoaSLe
	 Rota+lffoEEqqRUowHKWGL8iaGPZwKP9m9gXNxjrRta6s3cEJq+H/fGjDUWsEpfL3B/3W
	 d7PTGSFeM2tlea14LtZ3cf2gM8Hg0mk6/PdxyHpIf+TbCUYx1vaAGefiE6whvDXw4ilWb
	 yBpps8QYTpWOHAO7IU/uAwvDQMtGxCO5t80dLvfIwPBaSaWErxRiuMJtMT9UtpYCIdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DA7ly8Qk;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB6606A335
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BB6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DA7ly8Qk
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b54c019db4so246737a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048241; x=1795653041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiPMStJELJVEfo481tju4B7weEAXXX4fx2HGMzLvMQ8=;
        b=DA7ly8QklzTVI7vPByhXLORbOFKqcXC58tufHLEdaxrOBAgryP/bxMy8mJSB2CBH/8
         ado34FlA3guZ02gcBVrHlUq0WnZCAr9MTeyv9c//VuYh0Rjht8q2cqzQseKZ2UakxqDC
         py2sLEVftQnh7sMRtlOe+3Q33a+VTzYGzFL73vTTAt2BkjaS9KZeU2O2EHm8+I3a4SK2
         AuulkU7iy32PXxQbvH8aJfbM8R+Yy6Twtcd6eoXg8JYDXAqZE5K6CUPSbF8vkX5rZu5Y
         af9FdJpKLabOZkxQrTEds7KXKdFETs6vAz7Y/OoDQUHbEtMi7TF9djIVNa8O+k0K4x1a
         V2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048241; x=1795653041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZiPMStJELJVEfo481tju4B7weEAXXX4fx2HGMzLvMQ8=;
        b=tXPtAJs1ngNKxmr4kNyZ3QbqwS5ssVPklYr4EcFDwNhE4G5HhXchdp8QlfRN6wyh6C
         K8Co74oTjo45w5LOMw6hssZegpfB4opCa0mjHAUW4QYImBIRJwVq9RaCZEmydYzS8Q6w
         GXyqD5Vsw6R8zjv/praqwySCfCwb8Ozz9k2XXVom/GIvuBb//fvGS0wovB2jE6i8KFOd
         2BPS8Ue7SL5qAfuoxeZYBp0b08Y+utoKCXRykEeLeMyl2Vi+/kTC8PNlISw+9mXdXTQv
         e6z9DwVHpCQV194kc5y7ePNokpP07IAhCygImU13/FC8ajmFVqWVzzMcwhdyp4q5mQY+
         lzPA==
X-Forwarded-Encrypted: i=1; AL+hErFjcvROEoHtSn56W5QRGhDvgQK0Zhmnprrr3U5lwpG/V0pqOqSTS8GUc8Eo2f3srMlSJ64=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KZARnFX8xA21Ju2yUnvqviV3+5L+DUpeJTT6XnomhAX6PEauQ
	mc2X+AGn4dnt/MsbElhQ2YrqR2DlnI4eZ7keoxAnynTweWhWLYXs+sFm
X-Gm-Gg: AYBFou2LG1txeSoomkr6aS0nn42dsylCMBe/EFwoGXhgHO+AvjmnHRqy56coruITckO
	wLTxvu2/dGAwA59jTkCZ9czBmd8ZnoCn2qnuWTFrdSayio/GChoR0ohk7Oqadh5tAa2R7hp2/Ff
	g+FuXZPdaeASkkxslo4ct9ukjsI54s5mMlFWfzGCTBb9ljAkN+FU9Qcny1mbipsvR2ExLTmUMr2
	szKKaeAOcqCgrQoFLzcUQDr3zz6cgbcGn8W41MzMcBma+pYyYheys5NpYSe+RBPCsRz+JqCAsCq
	pKFfqkgfpKlTUnIi1XLBRaFYMW5dVOndS/9CkW04PeEybkcewvRwdKmUFyE0mvWtGX/oRbOU53h
	iDNPaaR9N873E6OEoSTjHqK7nhhV1KEtNrvLnFf9eko+EJDaII9K3EHOxk/IE2yRznO7b2pBD41
	/fyxhXauqjJ1M688uI4gO1712UnWzTLh8+lhXYgKVR8hhO2bucacjDZzkCLom4QyfctpImFtbDq
	So9eAmOd+j1PED/vfcym1FZvNskVJ1ZG1TyqX022bNM0zcd0OBDcVLc5YfVmMUDrQCaybnWa60c
	xwI0s8r6Md9XWrLYQ8VHQH+byQAfxfzmX3uFeWEJ/56PfjOqwDNf
X-Received: by 2002:a05:6402:3137:b0:6b7:aca7:4cee with SMTP id 4fb4d7f45d1cf-6b887eac9d2mr3678935a12.3.1795048241161;
        Wed, 18 Nov 2026 16:30:41 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.208.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a001123sm1729744a12.21.2026.11.18.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:30:40 -0800 (PST)
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
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH] selftests: net: veth: derive invalid-tx test value from kernel max
Date: Thu, 19 Nov 2026 01:30:02 +0100
Message-ID: <20261119003003.40482-4-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119003003.40482-1-emmaonana18@gmail.com>
References: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
 <20261119003003.40482-1-emmaonana18@gmail.com>
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

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 2a37d21f97da5..6eeb123aaf885 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -464,7 +464,9 @@ fi
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

