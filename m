Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3E349CC1
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826201; cv=none; b=E1gyM1X/5HsRvZKSc+nwuxnDRxjzpQTHcT3I1BG7bFxUrt0t71/h3+4FqA9FIWP/jLIIMd5vfPiBRf2Iuq0ibuP8Tv+Ww4T3AfgTaq5jV87o3mxjWUwB+W5gG4P5o/9lpbEE9soup7Sbn+xxiU3gTEyoJhvpHRnyqNp441/rVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826201; c=relaxed/simple;
	bh=+TdbYnoQjaY4VdUDOON5Er0hmJ0yt/DSv+vRdqw2PJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWIXXlfc8qk/2V7OXTrQXoTHVhEXBcVxN2oLLTIORjuJ9PsMDTXwAJKnthvsBo6UWEE4epHFjUlY5ioxBwkt9MmU2MVJEcgK72HCgafr/e4Yh62EqJB80U0TLj9wv9VKvEWau2z+vhyKxiq5JoHR+Y5KcsyRBvgeFLIzDsSElbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIpAkXDo; arc=none smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIpAkXDo"
Received: by mail-vs2-f36.google.com with SMTP id 71dfb90a1353d-5d762b6ce2fso466035e0c.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790826198; x=1791430998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sm7+Zf2VCuadsmAKKNiaor5/4aKK90L0b1pzxff1AIY=;
        b=XIpAkXDoi/qzgTTS5+5+tcW7bvluSHHsR0/u94GVscamahYx1Xj80h/ObOYD3zZot8
         Hw3xgeU2AmP7GMUKmLj2hSSlqXH/1WwKUU9fQqbH4UY4vLCL9EFtEpetVPF1jemKyQQR
         05/JP3IKsIHDWU8aGr3ti2toxb+mykS6835u6I/xPG1bxnX3ax0LlpGIgUaYfmGM/3Ld
         ksxmLbI/A+9hLKvWtqMvH1/ko+bcfkUkG49sw4jIFm4wgvYHCGdmEJfQ09V2IiCGY+qZ
         YAiCIHwbNdr457lnmyhgn4tbvV7l/wW/dZUwhNgb4uUNmI9GjkCIkCqFCXZM/zsRvPZs
         RCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790826198; x=1791430998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sm7+Zf2VCuadsmAKKNiaor5/4aKK90L0b1pzxff1AIY=;
        b=Nj8/vsysfZY/W0rD0V9aeBI2rd9Lw2tG0KY0S2i+/S1YM4pkLPsXuO74IsST/PZYOo
         QQhwCslYjHj327NXxCiIByHPF+FqXM/XMDXkf7ZZWOMvx8QiYdx6GmBGkzeNXa3EtPLB
         bjcUk81vLfMv4M94PhthPwjlA4QPuEV6YsIXenGk5YX0SJcGhHrrsk+TSx19KFLky8X1
         3fY4NjyeW8jTrvn6d0Nbv7/oiYnPLgVmM3uWTCWaHRcc9JwDzzAaSO629zlVyYoJI/Ax
         KWW0WEBotl9V/U3jArgljnyYmDRJTurFxOBMsZib7p25KjzHBlPgJoh3AFoLoM/uFgNF
         29xg==
X-Gm-Message-State: AFq9FYJp7MBilKlWNvQ6nG04i8KmcClDDefCT07ztU3j7bBhpU3hT9P3
	oU2dV97uA5/T1K5HBFxpYL4eZrOD/dJXCUTQ5spH4w84Wm3YnpHFS/TK
X-Gm-Gg: AYBFou3Jnn+6wvNbjPS7AaDEm7hM2J23k8F7PH9/GhBfyvchYOsuHqrz+1SVujuhw+Y
	SzLc1TjvYDXaGw4o94NhxXExtDU3KC5DCwDkSWvXrTr8N2j5GfKwjCm7/cMIpOQwiIPva6qWPvi
	Off1YhKgpcWSADAbt68wDbyoJMmErGNAaZRcD0XfkrapGlBgF+BryHF5Bh7Era/VqCwgW09GyDy
	F3/JH8gy4rbi4Bi2t3O3xpwSDqJFhxsghs0mFdsjuZBoR/pUewe9I8AimBlSQMHDNGHvE0cRKKV
	Rid8J9ezH+ves0Kr6qgde52uv4oDmpm6dgoHS1pvMR7B3rRX/esk3nMOaWVmquH10OUVDXVAdpF
	OZjxYHeLE1+mhsiuMArK0mwaDX+JVExtYws5XfMcm193+Zz3UQvyJ1KA7LqTlds2g7qm/d0Bjtl
	y4I4/JzCKyMUtJnJzoq+p+PnrH9JDdtnzoPoGM47jJVN4UgXDBaAEft/ZKyJNoJLoT12YP+drhH
	04=
X-Received: by 2002:a05:6122:6c17:b0:5d8:4aa0:7f6c with SMTP id 71dfb90a1353d-5d84aafd1efmr312839e0c.8.1790826198122;
        Wed, 30 Sep 2026 20:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([201.162.73.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d7fa499396sm1789926e0c.3.2026.09.30.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:43:17 -0700 (PDT)
From: Luis Vieira <luisflavieira@gmail.com>
Date: Thu, 01 Oct 2026 00:42:59 -0300
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add regression test for BTF
 dump zero detection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-libbpf-btf-enodata-fix-v2-2-89f6e8a0240e@gmail.com>
References: <20261001-libbpf-btf-enodata-fix-v2-0-89f6e8a0240e@gmail.com>
In-Reply-To: <20261001-libbpf-btf-enodata-fix-v2-0-89f6e8a0240e@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Luis Vieira <luisflavieira@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790826180; l=1595;
 i=luisflavieira@gmail.com; s=20260913; h=from:subject:message-id;
 bh=+TdbYnoQjaY4VdUDOON5Er0hmJ0yt/DSv+vRdqw2PJg=;
 b=tvfPGEeTxlGbKrxeJqa3cGqw8HGVbBuInj0jUju9hReekx8a6ss1kY2gH1vEExxh9Ovrgzmlv
 w3COn8NNw6FDrSE9D6pGqUvZ76Pi/vnsSKDQrd+SkHoQgBeHw9usoM/
X-Developer-Key: i=luisflavieira@gmail.com; a=ed25519;
 pk=98MeC/NdrC6ah7zYpPnkWiQIoyj62iUP/rNuV3esCW4=

Add a regression test for a nested struct whose first member is zero
and second member is non-zero.

This verifies that struct and union zero detection continues checking
later members instead of treating the entire nested value as zero.

Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 17fa44cb9c91..5a5ee001ac8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1146,6 +1146,11 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.cgroup = (struct){.order = (enum bpf_cgroup_iter_order)BPF_CGROUP_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},.task = (struct){.tid = (__u32)1,.pid = (__u32)1,},}",
 			   { .cgroup = { .order = 1, .cgroup_fd = 1, }});
 
+	/* nested structs with zero first member and non-zero second member */
+	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_F_COMPACT,
+			   "(union bpf_iter_link_info){.cgroup = (struct){.cgroup_fd = (__u32)1,},.task = (struct){.pid = (__u32)1,},}",
+			   { .cgroup = { .cgroup_fd = 1 }});
+
 	/* struct skb with nested structs/unions; because type output is so
 	 * complex, we don't do a string comparison, just verify we return
 	 * the type size as the amount of data displayed.

-- 
2.43.0

