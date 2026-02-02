Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882F283159
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060798; cv=none; b=aCaOZFqk38Vc1lsfRe6FexhQh0AlLhcXn4C8kofIbc5lRZyxjiAKjw3BTYdBnwRfr+T65Xt/LGjpcHMa3Dn+r+OX7NHdQhrzOuR+iuxAR7dzSFRDLNkVV9EmEFDRFalmk2bxC4rx+nyqU/Ok8UJGlkPVSF3MW1zSr610Duu+Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060798; c=relaxed/simple;
	bh=XK1uyU2bVvv5qtXv93YEPL7R8vN9E8IwBEoN0ycX2os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7u7PHRjEd9wqxpVtqlfxZhURXH9Pqhzc5Ah9unlhrpDrimcY0mJWeUGKIAvfBb4NDjbU/S++zlx0ytTqnx4StMbqFaYa23HAHkFVMyVmei0+ksvzaMjUf+fIW9ILU20jFe6NBe/Pz8xvBayfv7Jq3J2ol0XthYmjVqOe74Dk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=f8Ste4bG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="f8Ste4bG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-503354cb21aso44249941cf.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770060796; x=1770665596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9g2e/TtKCAdb42J3qeZLe7B+a56yxtl1eN3FjRo079c=;
        b=f8Ste4bGyGlThz1LkzTboM20ALMwApiAxlaSgJ8k4IDYD2nXx/6/+Jk7wR9cAcXRan
         R8sPBfFz5/mw3t9YZwAiWyNs+jutoapcIVWbYv1174CY1UFBpHQOlEC9QQrJ3betpx9N
         +csf0QvCd1C6OPA4O5+gBjIFpz54/2gsiED5oCpH7Lsut1eofUQ3KYbV/zVerhmjbeFs
         GAAJCtVsbKjyGPXxEVJGaUJyZ34sYF1uh8CrObydALlfNmKSYsaCa6lt2BUrO538ZGrn
         YYKQ0mr2EbOOr6rem3qbML0QLZc3SE9hb4M1G99NBbXTZn55rZAVU1EHTR3KLsrhQef0
         FPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060796; x=1770665596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g2e/TtKCAdb42J3qeZLe7B+a56yxtl1eN3FjRo079c=;
        b=RHwew+EjSjgswRTxUBeN43/MQDbOuDtpC/FJc1wlwCB+YkWPOjB4++rNfwweR/7ErZ
         HMI44EP8Uv49PG7WZwS0dnJ/0uUpvDme5X/E8AkMu7LeeBJ/0zH7tJoFn7CKjPH0z/bQ
         ieaYiV4C7PAv8lLQ8UiGBwAxwivaUB5fRk6UIFPiWg2tSufHRciPiEf2Uco8iKpjIUDX
         UUambbPTAJr/zC0yzYoEHzYoUnszm/NbspyuNchqhg5QLOT1lwQsjdhYhD+dTdh5rMHz
         zNs7KGvoY8/jPi41UzTMVRac3LyntaC189eae25oD3dtLrfkGLbOyPgOdCc3yQ0a6Orp
         XAnw==
X-Gm-Message-State: AOJu0YyoubaMqnB9AHpXEJCrxJtYKPZVBCaJULFTfeFNzXn6gQ6DnIkK
	4awoQsPqZxcbC1f7tKPSxgHhB8mpj8pdPsZGDLu7ADqo8FNVD4KIv7YopmW0a3FzS7/0HHHEiDL
	GOq1U
X-Gm-Gg: AZuq6aKI4PdE9D/Z50qsgcMEVzA5ZBRFupOgF6Xx6dFoLAWdRc/pn/gZMyZ6cj+ci7v
	YvwO1DGD55RTkQ4nS0yItpyQpjTdMx+kTvwrQvSz5ZlJxysfar891Ha4+HXmTbqDIHM130fsQGM
	IfZvtr04vwqzVsg2EFDzdDvcusrwa+QiE7P5QZmw7hfvPFPewmlNY/sBpnhU/0eXn7vb7vcOdgJ
	ATRvPBAJf4VrGhoTtk4kj8lRdd+xf//aNfShz+3IxKrH56/YFNCqw5qw0gD6dpnZTvVfDJ1acYx
	nBgG8sDmDXMlBWPXLhoHkYKKp9vNr6xR698fBgahihfPSxGZPC2/T7KCv1PRlznetp0uYTGnIn6
	1t1JpY6EIbcSkh4YRoo4KuvnCpZfifBfxWxeKt1RvC5ccWVIbJuOr+cAibAZSq5cIIeKZ0onFhV
	k5d5jf0yJr3w==
X-Received: by 2002:a05:622a:148e:b0:502:8fb7:77ff with SMTP id d75a77b69052e-505d2275bbbmr160756851cf.47.1770060796004;
        Mon, 02 Feb 2026 11:33:16 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm111971941cf.5.2026.02.02.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:33:15 -0800 (PST)
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
Subject: [PATCH 0/4] bpf: Add bpf_stream_print_stack kfunc
Date: Mon,  2 Feb 2026 14:33:07 -0500
Message-ID: <20260202193311.446717-1-emil@etsalapatis.com>
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

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

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

