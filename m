Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A733E377
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141881; cv=none; b=YjP1z4gTvymIzfOCNeXkBeeNcQBogRNYOGLtvEzW/by06/Hy8PrwiJjGztJjG1PfysRaqAvHWsmQ/ILmeFOsIEMfx4EYdwwG2BdjmT2knVuYpLfnbe9zqeyDMITg2aBXWXiK1Pun3E6YusIBuoP00r7vcfKUOVKy8ER7svJ2AZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141881; c=relaxed/simple;
	bh=2EQh8v4iSvt7JY3HCuEm9WMrqzAnKAznUeV8nugwArw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okdt/IIhT992BsAzm1IwFB7NhfQlKUtEQvlxduOAgTFxym88LRcay5uQY9dYy1Y/pF2NAGuXcfo+gFrALu/vSsgSxW/bObQ7Kn2jDIzNUwAvRDLhMUc7igynx3uOcYDOvolGjWGNKMUW5L8F5OYCVh5vN5VR/iw8ol5UEVGdWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=p5TgjJ5g; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="p5TgjJ5g"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c52f15c5b3so597535485a.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770141879; x=1770746679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lIE4onBM72BiEcfoX6iBs6RfboGGiFM5XjSVrEdPbs=;
        b=p5TgjJ5giaP/jtjcOT1jKI0yw3FLvNVkc6l3J3gdvi8C4fSgjAbc0jMPV4k7fibf4B
         uIlHJjMGEXbmjRGAgJmuV0ngjGWJZO7sUXX/4iRAO2f1ZyEN01xl66zzahv4EjE0wPNr
         QsSnUxylO6YD/S3DmdiBXAWWyW/KYpj++VQDCSe9R3ONKcNNFmILFOp0r0TxSaC613so
         pgKKX2IXXBewzi31GJCWaYPzyh4DjZeW3ZSG/RfH4pZk7MiYsLb/6QW1CvQKX9eVanSY
         026kHyZD4gIViW35j7qs63ltHWLcafDoLF1ujzmmqQqXw4tjTmUhlGCVIihv9lOj0XUs
         NGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141879; x=1770746679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lIE4onBM72BiEcfoX6iBs6RfboGGiFM5XjSVrEdPbs=;
        b=Sd2DG5hiR0giSQBxl4OQsRYkBdXRg/eyLnnNcwIhAoqGPcchbpWIlDJ29OYtgHjcKm
         kmpuEyCBdKWyZlRbogflUpunkUhadaVUPJtKZe6Q9+L7kFQSaArnbPmqyENeflm3yOeG
         uumvAMnKeNHM4JXvsmMiXn379+T+AmJfQ2dLunvkhb7ta+vdPMwervylkuHkBVRWSHwy
         1gd2V+Z2G2RQmKJm3rSSMUqB4JdhvE2AwFYm+A1HqQEeO4LDzhGuVRB8Dv2MWpQAr36z
         vLMugvJCg52mQ8rB7Zv+8ALlaJL2cPcwBbRFJGmG3PvwQhh7J2LnBbaUw3cZ5XY1KP03
         ayZw==
X-Gm-Message-State: AOJu0YzwkDWoFKU6T5BsgsqW5v2094wF1diuQ6o1ivDWlzFwszCYFGqb
	PsU00jIQEuy9rEzySE0fYb0pndifnYG9oGFfACJkY9dX3H9qQvMU4WKgPKYWnIRAhcyR3LUJ21F
	E9cEL
X-Gm-Gg: AZuq6aIFjqbVXaEFwsJIOAqLPi/f2g05ng2OfWiwpFXzu77FqxarjfDjE7XpCABFUh9
	PVqdk25Guq5Y4VQlQsT+QdgfvCYJBFYFPkuNYXxTCwkgzKmk1X+sbnOI/8Hr8B9waSKaOkXqQWp
	K6Gmwg33yVb1Fux1d2Jk+3JaXI8478XqeqRkyLfrE5qtKJgQ/NHm6nhGut4OcpSgZIca8omwRvY
	EQssFgv2sJFjWxxZAR9mPr3QJzhTGBm10fSKPO33Z7t/7/DFgIo5nWdFvWtR9hkE4SB/+kCo40/
	So6vbQW0g8CXqF5Af4m9CoZjFM+GO38vEPLf3v2jtJd2dzo3TidXQXnNt19GeUkNw6SBZDOeKU5
	8spUksEj5N5DowjyLorzDRHDN3n+NHrmRuEEHWJbvvSBbvfUMHh0qmJTA+sICwdYUQkdh1fxSgH
	bR7VqCHQ1bPQ==
X-Received: by 2002:a05:620a:294f:b0:8c6:670c:953f with SMTP id af79cd13be357-8ca2f9b7035mr59108885a.58.1770141879045;
        Tue, 03 Feb 2026 10:04:39 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm20469185a.14.2026.02.03.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:04:38 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/4] bpf: Add bpf_stream_print_stack kfunc
Date: Tue,  3 Feb 2026 13:04:20 -0500
Message-ID: <20260203180424.14057-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bpf_stream_print_stack kfunc for printing a BPF program stack
into a BPF stream. Update the verifier to allow the new kfunc to be 
called with BPF spinlocks held, along with bpf_stream_vprintk.

Patchset spun out of the larger libarena + ASAN patchset.
(https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com/)

Changeset:
	- Update bpf_stream_print_stack to take stream_id arg (Kumar)
	- Added selftest for the bpf_stream_print_stack
	- Add selftest for calling the streams kfuncs under lock


v2->v1: (https://lore.kernel.org/bpf/20260202193311.446717-1-emil@etsalapatis.com/)
	- Updated Signed-off-by to be consistent with past submissions
	- Updated From email to be consistent with Signed-off-by

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  bpf: Add bpf_stream_print_stack stack dumping kfunc
  selftests/bpf: Add selftests for bpf_stream_print_stack
  bpf: Allow BPF stream kfuncs while holding a lock
  selftests/bpf: Add selftests for stream functions under lock

 kernel/bpf/helpers.c                       |  1 +
 kernel/bpf/stream.c                        | 19 ++++++++
 kernel/bpf/verifier.c                      | 13 +++++-
 tools/testing/selftests/bpf/progs/stream.c | 53 ++++++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.49.0

