Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048215;
	b=a2Qkvlw98OqIQyxGDU3EMOzcBZUY2I5bI9Ur0VeuF5aDC+N/aIXVOD9Fh5y3KOSyynQ6
	 wWU2mJ2eeC8TK0JlzkXLUpNOcw03WnMOOu8hLp+HMRNqjWIxbE4GpQSDdVzdlpzWvjPOr
	 AbS/LkS/qkSZtNlFasBrnsHmDHUOumZD9cdteYXb3PI5PA44cIf9UJs8ZNfgf2Ecl9BQy
	 mDPEX4qR9lG3tUo0neYCLItdmyj4kUydWxRGtVkBhTNZqo/TmbK7lb6Nao6sw6x6JR85o
	 Z10BXP1nnbXi9zIZKeFxe0DJZ4w6qTCvkTOcGE/+jbnFMM26DK/cQGokvxlbiVAat4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6bMRA063A3AaOLf4nBgKeunZjhvNaz9Ho8DKakkM8c8=;
	b=MhsujvLxrhwcsiDl0PN/iWO2z6GBp4LbNf34u3Ei+qJPOnRYd2LeV3dgd4vJ/bPUX4fW
	 5xvJBQz2QSJSgPuCDyX709t2hHjbeVQ1wg7TMHl5rkLHBCqPjzWn3Y9a++vRIm9pVsSwd
	 GmUylx98xiMie24yB00fOmU0Pv6+SG+TKXb1XHK+NthOezmX4lgpUaBmgPPnvL1qbN1fU
	 grsQdBv5YSUYggFLgl+saB+P+nhb41pgL7VYaf/smC8QvfaVUZK4foGZTkRcTtUkfn6F/
	 O81fMtTv4Th33P7FvCygEHpY0nyD20TU46iNGjUeTL+84f5LFONGj9sGYH3QgwyRY3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UG3Eh/SQ";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AE60A260B
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673AE60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UG3Eh/SQ
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c504707acfeso36731166b.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048214; x=1795653014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bMRA063A3AaOLf4nBgKeunZjhvNaz9Ho8DKakkM8c8=;
        b=UG3Eh/SQUGCBKdVHe8THw0oF1joQ0Y2EbkldtFzyon8Ud1qfZ0vF/2rOG1imp6Qfoi
         3nsJXuyQpPY6pzvC1NxI6mC/O/aTjVMnen4tckd1G1//jAAaTMzyh1dg+48lNNgoxZ7m
         rTcMET2GtgASluuAmA24qN0JrCrcQ9A0gVze2pVC3lofr5fe7ha+OqUh/nBnpR1DOvXz
         9nanKjn7kn8z1Z7eFpcAirXsfjLAyftZCmJHa/zHCjnQwfmYBhiCXcj/LPAcuXFA2zx8
         tmXPC6sqQKl6MbKwMOs0bNaWEd5ysoAkI/KUs5I/lgvxDF4bnA2JXCLz3KAaNb36nEvH
         IZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048214; x=1795653014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bMRA063A3AaOLf4nBgKeunZjhvNaz9Ho8DKakkM8c8=;
        b=foQYwoEXjO3zwfYMNW3TrtZOsJmBLrAv+3SePP4DE7KQEnGjAgPy2EaMDEHuBjiz0u
         i/YkLq4sx7+fvgUeWTB8ZVggjQBhE1fbWDrwAQFS5h4qQQVrESznxddVdoRoMH/XoN8t
         deNvYXsSyxuadCU5CPFqDFIY9cL5Uyb/dviKiJ9LTfsMtToUHGu9dKyo+ZQI+loJgRJN
         MbCoOfjmA6xyTKqeucikyS0kpxWSqEvhkrR7YglgWC4btug0Tm/vfaQRA4ugU6RtxzkE
         56UHTsI/UyL4HuR9CPblSS9uOkyISQU97krgSnqnM261S46JlQGT5e1gNtbu1XfnBraw
         eREA==
X-Forwarded-Encrypted: i=1; AL+hErGliHfsHiM6lEzIGUk5aGnNdzi9kJs3sZFEcEUD5YE6FTdj73uv1FaLvsylbb6kYhDR3Kw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RfZbXV0QdDIH1Xj+Gzw9GbpftIYLd2JDvu8akDhFjKNhBnG2y
	70uH72q0Yd245vJQPeJF9+Ajrv4sFPo9XJSIARdkRgrRLVXVXQ+JPPu3
X-Gm-Gg: AYBFou06xwV6Ip+vdAq5yNs8eM2w7+AHHB1pkRAIIaH8zFxWAj4OtaT11YlCbSTeRmG
	Te0NtpZ/LyPHpo09DeP8IHEFyFXxteoCZSaLBwm0+i+67CI8D8Bw3mYBmYZaQrNIV81UwSgikRE
	U/hwvWjJ6AsT/c3SV3qkosBfXdZE5sco/kIuaTAp5bVyX4JH74QvurzkebI/CD/Y5mNFr9fhipW
	GnY3qf5fnWtULpv3HRoNfwhYLwR7Fp0xaS58MlQ0EVlFRIJJqXPl1cfBFskV6a4fB88gZ2FqCvf
	Mujv7H0MZKI6sCCEhVBxtIF9t9VI+ficrc8LG+r6+jH1QWciShkEHJBkbs4cHHktWKTGMDYzh/l
	meU9cprIP1VK/3qOp3KJMFB3T0/vDZAeo4gB7AFabTU7xnUWzFCqumHJ5egwtG8EYEY/9kVImJo
	L11M/P4kURIne/iYEjH7qzHVQqV/JIyxc/qZzYB7pud3EyNLgffuXi3IJJAy5gV0/WUhxk2FoVz
	SZIelUnnHNuXXW2FeXsf2NUM/+psA7isg9s76fWLDjrBE7Z6iCMymR37B7FmRXOh0Z2zrGA3Cqx
	PmmygNPTp/0AKSYHE1v9HKi5O5bZpFpugNeXcXe50Q9htH1ip81A9A==
X-Received: by 2002:aa7:d152:0:b0:6b8:7d2e:838 with SMTP id 4fb4d7f45d1cf-6b887c69449mr3774897a12.1.1795048213632;
        Wed, 18 Nov 2026 16:30:13 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.208.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a001123sm1729744a12.21.2026.11.18.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:30:12 -0800 (PST)
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
Subject: [PATCH net v4 0/3] selftests: net: veth: propagate check failures to exit status
Date: Thu, 19 Nov 2026 01:29:59 +0100
Message-ID: <20261119003003.40482-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
References: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
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

Patch 3 fixes the invalid TX channel test, which used nproc + 1
to determine an out-of-range value. However, nproc can be lower
than num_possible_cpus() when CPU affinity or cpusets restrict
a process, meaning the kernel may accept the requested queue count.
This could cause false failures on a correctly functioning
kernel once earlier patches propagated test failures.

Use the kernel-reported max_tx + 1 instead, ensuring the
attempted value always exceeds the device's supported maximum.
Spotted by Sashiko AI review of v2.

Changes v3 -> v4:
- Patch 2: use if/else instead of "&& { ...; } ||" chains, keep
  lines within 80 columns (thanks Tianyi for the review).
- Add patch 3 deriving the invalid tx value from the kernel maximum.

Changes v2 -> v3:
- Add Tianyi Gao's Tested-by to patch 1 (thanks!).
- Add patch 2 fixing the remaining three checks.

Changes v1 -> v2:
- Correct Fixes tag to 1ec2230fc721.

Omokefe Emmanuel Onanaroghene (3):
  selftests: net: veth: propagate channel-check failures to exit status
  selftests: net: veth: propagate bad-settings check failures to exit
    status
  selftests: net: veth: derive invalid-tx test value from kernel max

 tools/testing/selftests/net/veth.sh | 31 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0

