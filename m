Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285383;
	b=QQKmekcsJGiC8EXXWnxlm1ZewWOV3kacACqdZYAwPPLAuB/gnF4r50fU4omFWEoOi09T
	 V/UhG6ep1s7utiwb23BBSCH32McMkJwmgXo2xMujgoXe8TBSnQIonkvj2jMLofjipH4N1
	 fwYL1H5b1muUtoibHsolXxWhEo6FH/3F//MjG88T9k1DZ3A+sndvXqNzNth8bCGET0NCv
	 U4bRe3PVNdh0ijNCFOQQNQBZSOOkPLviyRn0w6y4LYpp3wHy3ZnWWbNbYBfr3KGZeMGyZ
	 Vsy/b2BksCyC511sfqPN4gRaetJMhr4RiaWaSkCHQHUC67FCKgqT87pYFH0ATer9Vmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o9NEFNsCc2NcvWKzT31mhYcyJnIDEUd26l3VnghLY1E=;
	b=NSKIgod2uzPwDUaqWKv8w9Qnm03lsoed5t1elCCJElin0KPZ07YJanSRQhpLnZczdgIc
	 cnLOa4fUul27pzGOlNkDHuejetFpIrfWt25pxOmMlfN6F4aJmIURWvMdF8K1nCq5BPoPT
	 5ZOl2UQSE4pg0mkgZG/pmoe4wC+Fw3hnmBtHEph3oCL1DGW37xrzdEqbOzn56bpUXQLZ6
	 poU9jyjq04L5L2IrfzVCBBxW3NnIBAz2fMLSksgUIhIcbttenFxEdh4nP/zVCzWYfuBld
	 5e1klH43PPhMTGuUELJr1vcgKHWX9KsCPTQjcG0EOv/hw8VX5yqzFdKCX8cexTSwuhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+uj6aRa;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3E606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 18:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF3E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+uj6aRa
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so4103565e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285381; x=1795890181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9NEFNsCc2NcvWKzT31mhYcyJnIDEUd26l3VnghLY1E=;
        b=d+uj6aRa0JypX9ox6qZscWxSUxC7fqg0E+T3t+0FHue6GwYr0GnyLPk0milV6Qx2sG
         gZ0Yk8Q/1UC38PopKspEizuRHpxviyq0By6uWAwW008Tap/ZGuTO/Q4J55OXrLmBjNpZ
         37Ba8lvXdMc0XdwkvP0A2GIIII5oZlzqGOigeYK6wRmJbqVTd0MvYqNS5MdV361f9vQ5
         kc1Kyj31ddNQ4eUf3KbDLmmzUUkIt3dw1D2kCS+sSK05KrXgz3CvI/1dA73mt2KmcRZN
         J9mW5kvXkzgQ4i02o9lspKbFcjuns+2Cc/CI0EFUTn6e30E3RlWqrhdczIjKvql5KEmW
         mTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285381; x=1795890181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9NEFNsCc2NcvWKzT31mhYcyJnIDEUd26l3VnghLY1E=;
        b=XA4m8rkpP9+puw8tg2up2w5h1Q9OMwsn+bYq3MQ/UzYIvaOVIR1/P0VBtUayBDnoIg
         jn+lfH7Lxc9bPbdFeZWkXiwdJCvQN/l8imwVx3j1fPSH7tiXT3ZCv+n34oC3pMErI8HH
         1S0IpL9Na7mlMZ+KLTtY4/gFzosK8KFJ6mvtDcot8MR/Owcm/i6uwWnPYswf0BGAefMy
         ShByo04tu9KTZc6vbUwLkF/aqhIMgCiMktg8o/mczrZFjcnTgF5YSJ32zDh2YKzJYDEB
         3LJmWL1i6fiVayxNLyOfCQ3adq3xpTPk2BL2PScSlJ4khmsPQaSx/XW4bokWISoowstE
         QrJw==
X-Forwarded-Encrypted: i=1; AL+hErEbgBPPZzIRXg0O/4Tx7nl7SYKNRlWUpMdTo6lsrlxkxSccFwsQ6I2W7M31BRW/sFwNY70=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bzv10GseVhYQ3ZFfGrYVKMky/IJOHeZVwzy+RGmU76E8yQhR4
	lK9PPMIfhKl/xT2934YFDxpoZUD0Z8wRcLGUN+YVBRX/CkTBDBHCy4KU
X-Gm-Gg: AZFdTZfTYyRjEt3I5IP3EF7fWHHB8wWh/neoQT3QJNdhzEOGmk6A9b7qgifupWsLuuw
	BNuhfG+/3QyZiZOEQrytA8LYFkn66HUi4AAY79JXn+GIaDBf9+ImAR3Z8u+kzR8emuDzaPNloyv
	KAouqzcIJ+0aXviYy9qaVSq9FxEPKbntK8ikOh51NmCXYzQnax5Xfc6zVARMViaLGX3oAnuvOX7
	WqZjfpGNYwdnCYKGVgAhhWaIWsfPUqR9mFrfhO6MOIarju0KnWFvDBLQxcI3s8VyULUs1Z4P9uN
	eR6q+ZWRiTE39i8Pn23S2vqi+l3MJJbdBSLhjfb2FMoxOvtX7lORBmE5A/l5d/kd9pC2YU8ZNKE
	+4OgcDolpm9TdR7Qvn8qx6mzgaWZwBGJfk8+VTBRTtkrWDPcLY0ZtE8178Z9OPPBz+pcpPkmetF
	t2gBC1WnmBZSdmbTXSqPIVAq+Gynq9UXGkG0EovDo/vYudijjOIWTInLWvCgHnsz2QyINWJAkO4
	2nxTGpFZzHCdRlhOyP0rXtDILg9TNNRBQb+wbhESdoQnsYMo1Uh+ZkvRGj83QcGAyxDpWcWeOYC
	cUumoCqGcRqh4B93MT8QGDFuYCRGZJaOEhg9MaDVwmb/jLJRJ+RhaZcqI9iIEmDTPF+EKw==
X-Received: by 2002:a5d:5f88:0:b0:4a3:45b4:f0cc with SMTP id ffacd0b85a97d-4abb253e271mr13430436f8f.3.1795285380632;
        Sat, 21 Nov 2026 10:23:00 -0800 (PST)
Received: from Nuel20.localdomain ([102.90.87.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm14215507f8f.24.2026.11.21.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:23:00 -0800 (PST)
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
Subject: [PATCH net-next v5 0/3] selftests: net: veth: propagate check failures to exit status
Date: Sat, 21 Nov 2026 19:22:14 +0100
Message-ID: <20261121182217.4609-1-emmaonana18@gmail.com>
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

Four checks in tools/testing/selftests/net/veth.sh report failures
without setting ret, allowing the script to exit 0 even when a check
fails. Set ret=1 in chk_channels() and the three "bad setting"
negative tests identified by Tianyi during review of v2.

Patch 1 fixes the invalid TX channel test, which used nproc + 1
to determine an out-of-range value. However, nproc can be lower
than num_possible_cpus() when CPU affinity or cpusets restrict
a process, meaning the kernel may accept the requested queue count.
This could cause false failures on a correctly functioning
kernel once earlier patches propagated test failures.

Use the kernel-reported max_tx + 1 instead, ensuring the
attempted value always exceeds the device's supported maximum.
Spotted by Sashiko AI review of v2.

---
v5:
  - Retarget to net-next and drop the Fixes tags
  - Move the invalid-tx fix first, so no commit in the series can
    report a false failure on a correct kernel.
  - Fix the subject prefix on the invalid-tx patch, lost in v4's
    send.
v4: https://lore.kernel.org/all/20261119003003.40482-1-emmaonana18@gmail.com/
  - Patch 2: use if/else instead of "&& { ...; } ||" chains, keep
    lines within 80 columns (thanks Tianyi for the review).
  - Add patch 3 deriving the invalid tx value from the kernel maximum.
v3: https://lore.kernel.org/all/20261116084107.6675-1-emmaonana18@gmail.com/
  - Add Tianyi Gao's Tested-by to patch 1.
  - Add patch 2 fixing the remaining three checks.
v2: https://lore.kernel.org/all/20261115214702.50817-1-emmaonana18@gmail.com/
  - Correct Fixes tag to 1ec2230fc721.
v1: https://lore.kernel.org/all/20261115212117.48496-1-emmaonana18@gmail.com/
  - Initial posting.

Omokefe Emmanuel Onanaroghene (3):
  selftests: net: veth: derive invalid-tx test value from kernel max
  selftests: net: veth: propagate channel-check failures to exit status
  selftests: net: veth: propagate bad-settings check failures to exit
    status

 tools/testing/selftests/net/veth.sh | 31 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0

