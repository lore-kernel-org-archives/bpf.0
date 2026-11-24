Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556440;
	b=ARnCovu/RQkuPEcgAQjyoAV7wu+HGHX7Tdko2V4TlJ3S2sUkASZjJ68vpAJXftoBr4A2
	 ckUpVyZDmTYoBtq4gjGvraKh5txXvs7/vRn6dQ6WQomX4t447Et7kS3crgDAF/CWEX8U0
	 rDYVw5o2VQ/k17TQ17BSF/zuGIpPYi4v8OKr53OxslGkGVMp95n/Ofztv4NwT1odUiVqt
	 c0YzHlUXrzbISeJ0LoDK61vBJvvgOj7NL7GgrY73vo/PvVrfB0EUWHxXkoTJcLTF0Jf2M
	 7SVWkS2EV7rw3iacMuz6+hM/X4HTiz8eEVSRJcjytkQ4L6x2qGimpQeG+WKujqnyazQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G/eu3V3hH3gYq5N6oYxvKcGt2JCj5qQ6/XPw1INj0j8=;
	b=GrNAruF9BG3vQF9MNxxTM6YlY60rVMghhUdiSkOVN+foGfj5uPWkIryIzgk+H+sMccdv
	 CEC5ahHnpHrWKcRy71lRl+w5e8bgdVeopJXo5jaahO+VSfEEIr525Vd+7+5FiaEGg7OdE
	 lWyAtaIr/yhMGbdmZTu0frhDa5ZNsX6l9MS7A/tM3l+CYqwswYNaDj2VMLsCMm0eiff1x
	 //wTQWepQkG3o4J8DlWBA+ygS3fEKveinGGWkWWzrpIw8M5nWVd00FRQ49i+DeKJzCSka
	 /3zREGUVCZmfJ0UyUi5YrXsPkVeS4RKfv7KhFcNOeai2ehhxKsO+l0TeAhcs6hRT44Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mi8EGLvw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD3606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FD3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mi8EGLvw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso11556325e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556438; x=1796161238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/eu3V3hH3gYq5N6oYxvKcGt2JCj5qQ6/XPw1INj0j8=;
        b=Mi8EGLvwatR57ciZPnajH53XIycar73TLMvtuIgZrwr8o59gtggQQ12mCJ91lZsq8u
         hmGmFwVYMPA83aVk24Xo4veC+N8ONh3aWgqYZaZoz4Rhy9FAgEDUPPVsJmp8wl4GM3cL
         dZYyW2R8epRb2L0WJ3JORZ52Taa2NIbTM1aG9RIXISLhYWq6D6F+2jkiqBUz0rVeL33V
         gjPJBdJRd4sdJZwTjxdQxtzokdIxRo6OkKAQzVKfINPVLgmCW9YJ5dVdo9qV+ccr+sB9
         rAbO/DsbVfBFUSsTo1+IRd9DBn5E4y82XPqJYb6REWyfmJ46mh0zyH6v6LgS5tVwjcie
         fvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556438; x=1796161238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/eu3V3hH3gYq5N6oYxvKcGt2JCj5qQ6/XPw1INj0j8=;
        b=av7M0cVjtlvsuANPyBOovNLHVYZfGhSGrnS51k5G8t5g8v1Sx5gDpDt4iZhsemhrpy
         1nKJ7bGPuWk5HS0IThvFBoTNAU/xUrAbcfdbzhC7s1hpEH9YRzNGWVFnWQlqVuLUGweC
         bv5NLGJ4E7RZ1W12R9UbayyFgXTi7RKUsqjxJ1XWADqHTPsgdcNYPkFuaa57iUN4kYXI
         4CF4CQ1XIRYWq2XEUl4bg+Qdga+WnksPtt7gJoJXHLcJsmCuUCgOVBiY4qzIjeFtVlVK
         nqpqoABT3grSgTw+IhDRNeGWDLbvP66LVcYN2RMwDDVTtPkIfltKSYfZnU+7w4Kb5Jjd
         jjhQ==
X-Forwarded-Encrypted: i=1; AL+hErEZPiEBkZAwM4tHANvAY52nQnyVAbOpH0F5VgAR23GRhrmVzVNxc8lSv2fu3YGNyjSHTD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZWqgsmL9iCgWdodZM2e4j2x+FE/xOdI9Ye19M9qH9ANV2Somr
	PkF/VYP5qR3B0W9mucknZO9X+q2kwHYP5SYtqX3phTCnW1GsRS0crhkRztgDKRrFPTETgQ==
X-Gm-Gg: AZFdTZeT39apLMM0BWw3nGvTBBomkPdAtQRPvRzq4gFgOuMRu3eFSUwBVkM0mDy9rKn
	7h/F/x7XWoEOMOj9XxUnSOcp9PvYhv6qav9Xx//eHuWei/IsWyXLQrl2KBpBJUQeJP3JJEJVEgh
	CZfh4zBKD1v5QOLwPUrVNThsYFkkpxFdGJTtfUoGETpJ8EkenJR62z5Pf8jdP6mgNgFgXQbzPMr
	i2+b/cQtsoA7TqYKK0gyyxl/z6bjKQWwz5QkzLrJTXYEY88p/nK+ejS2XKQwgyD5LA/3lW6szwm
	12G/RKA/Yyk7Htc8ovOd6n7Sx66WIcFp+tlN8S4/pu2rtp/BcvQRydgQD1dp0gUU1m9vbgpecSJ
	1O4rvttigCjq9QHHCKhs2ZI0dQjcP6sF9YKsbt/tgfoYY8xfrMFtnwGurhTPnujXQsIHQXaqpwS
	WoGX7YS3U3va9aPwR6x3a9V1/GOHSMy+J5YsMhYWfhs2LBFOWFAfUJnfP+2Qfq6c0rL3pIvs5PM
	4UKVBL6YKXSox0iQohwUmIlOWfmhOAJUhUI8oNS47zRmGwOG3tJqDDIuWm4wka0EOOiqt7Mxe7o
	EmQ6xWdi4PtIx6hUev8pmFEQ4WjF4iOAYRmVXB8XLdfmKSMD59AXI4hiLUwp9cOHf0Ibis3qMRu
	g5nrotzueiwpjfg==
X-Received: by 2002:a7b:c84a:0:b0:4bb:732a:2837 with SMTP id 5b1f17b1804b1-4bb887ec609mr239453505e9.1.1795556438029;
        Tue, 24 Nov 2026 13:40:38 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm28290872f8f.34.2026.11.24.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:37 -0800 (PST)
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
Subject: [PATCH net-next v7 0/2] selftests: net: veth: propagate check failures to exit status
Date: Tue, 24 Nov 2026 22:40:23 +0100
Message-ID: <20261124214025.11603-1-emmaonana18@gmail.com>
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
kernel once the propagation patch makes failures honest.

Use the kernel-reported max_tx + 1 instead, ensuring the
attempted value always exceeds the device's supported maximum.
Spotted by Sashiko AI review of v2.

---
v7:
  - Fix [1/2] subject numbering, lost in v6's send
v6: https://lore.kernel.org/all/20261124211645.5751-1-emmaonana18@gmail.com/
  - Squash the two propagation patches into one  and add
    Tianyi's tags.
v5: https://lore.kernel.org/all/20261121182217.4609-1-emmaonana18@gmail.com/
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
  - Add Tianyi Gao's Tested-by to patch 1 (thanks!).
  - Add patch 2 fixing the remaining three checks.
v2: https://lore.kernel.org/all/20261115214702.50817-1-emmaonana18@gmail.com/
  - Correct Fixes tag to 1ec2230fc721.
v1: https://lore.kernel.org/all/20261115212117.48496-1-emmaonana18@gmail.com/
  - Initial posting.

Omokefe Emmanuel Onanaroghene (2):
  selftests: net: veth: derive invalid-tx test value from kernel max
  selftests: net: veth: propagate check failures to exit status

 tools/testing/selftests/net/veth.sh | 31 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0
