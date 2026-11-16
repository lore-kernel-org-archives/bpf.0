Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849310;
	b=zBeuUnT+cquknoc0SFqVv9VQig6zPkQAp79xgNV691eYoCCE7OiuEJ0phKAvDBuoKf0P
	 THz2Be/ZcwoP0flu/d2EYN2hV/+3r6KCX6kPB5FU5DOP20ZqsXkKx2Gm9wH4tCnSIq2lt
	 jMuiVdnxzuUrDD/sA+cpoQYx6Aku8/0eNLRakwXHJdvYHsfM7bdm8c/z+++VcUEfMMgys
	 2smsyl1izRT/99gIMDZoJc74FlMOwr1MYLNYpw+IJMzg1doL6wXTh9dYQDE6Quk1rpy3G
	 DsyOTAvWDvvGpClHFNIsrhn/b9wlkqoPuM0Y+fD5JDittB7XKU2NBWofd7mFckIwbNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SnIAL9Ld5dmry2xIKJXTc5l7jOobd9Cf0HDPQZMDLm0=;
	b=R8rCRd0pRneKvYPtlvdMztYgQuLCO48wg/nPMosKKcBMWqurc9YOSxmGm9VGmArwe7JZ
	 0729RXcN2dB78Yl1/jRlBNn97oXtK7N+EnBgQH+Wzf2iP3Ln+WQ6Cs33UU5hLHe7wQs7I
	 zAOXJcJzCGYlei6y21cWDr6Q0NFBaMEa1wO/H3jDkKokhK1sf2Euxp5srVtaf/Sv+5x4w
	 wXesed3F2fL8FsydNm9nEq5rWbluFUxsAajsmn/YGfSXzfK/TGPWnED0FT9oShH9FprYc
	 fJg2eUxPIPal790btYFBbljzQRcqnWaCcDamL/jKulmkfVy2UvAm8pwEgHOSK2HrCUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPeAPlk+;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA947606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 17:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA947606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPeAPlk+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so2319402a91.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794849309; x=1795454109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnIAL9Ld5dmry2xIKJXTc5l7jOobd9Cf0HDPQZMDLm0=;
        b=BPeAPlk+jRpLnePRs+QNuzBU6xDP3ZVzV0UCcs30Ph5AFci32D8BA2iuxiB7PTkkxS
         4N9890b0AhomSOZJ5IBn6wcnTYCLz+j8rxQCXla6fkqTs631ZaoVoSoU79zbTpJdJDmn
         X+FolQ6YP/Nzq6mOSHqifCwj7Mo4O77TQHl0WfWFwkhhWnpdYvB2AgJZWXnNzE/pcZsV
         osFqpFU2UiQnFfCl5BDVpeBfjghoHEvw7NPiOoGTl9UK7IuwMdkaEP5Y8e0DyywHB2B2
         hLsimx2DmWUQR1ByeBo0VJkVnI1lpzbK1Uhb5C/T80btpQcvOeJE8UJqe3EhHDH+8/Po
         HLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849309; x=1795454109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnIAL9Ld5dmry2xIKJXTc5l7jOobd9Cf0HDPQZMDLm0=;
        b=pXdbd7r2bGznX3cyuE5s9LrLHLlV3cNnlsY6QfCrnamZoHLq4HfUXgALROF42UicJG
         0JMHWKbrJ8jT7K6chUYVS1HrfMzQjHxrt811OA12FqGeO6hOVf0+XPMAryniPMDIgAqC
         2JrigB7LeV27z5DI9uOYFdAqZRRKxQJQeadIBYLTPC8kX7yaFU15SU4cvnz6B9ORzgkT
         D9lQoSS29VkZ1PW6E0Rtkq0j4gkyynfRSBF22ERSlnFMvDk0UMGCaBHvN6Y4B9V29Lac
         HxTuBEhLYwjn3JtJClEc3aEmc8vHByjRiyGd+7qV17iSSkrT9KBy70uvyT/eziRGzQyR
         2ciw==
X-Forwarded-Encrypted: i=1; AL+hErGDVCgG3I7zg3OTNXuRSuxQerZEisio9Ddn1jTl5MDsPktKZn2ABBIjWHYL29lZQ9uaJRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tiiCzPn4b56pjEhqIW4yVHAYPErJO4lXLFp98W5TNkzLzs0md
	Ye19ARxpnzSYDugkzx0vBcBQ2dW+kkgHovaXvmc4GwCtCQ4TujTzYVqm
X-Gm-Gg: AZFdTZf/6P7j8J8QUKjBVagGuPgoRMwIV0UACYdL4hfHHGKFGH+ElnDjzc3XetzCgmm
	u5giGKLXfOj9q5jIPW9QZ3uJshqmJhE5NU8IjAFMPU6FVmFtcqhhgFBVw5Iy47waN82iSGvPWkp
	4czGdnTcpZFrddIxz/WaKtfQ9n0E3MArv+OAHNGkfuoq0samPHvvG28p0vXc6u+HuZJLWhgSoJz
	sHO/PQvjMv9zpu3YO8Oh7ZIv82FtlsGQsu++AnXhACZUYV6glMoIhK1HSps2wudAZ5wnf403HO+
	EuZXw4NT50xYokbbzvlao8CMPttNkrciBiWESQM63AuVcgS+Elr78ewRCOf/EKY/n+ow5460Wqd
	oHRylKo9Yj15lKdDGczT3qYQK/9uDGfWzugl5L/X8gndxzkLh5tlMXzCt+N9RGwVM3vyzoVnXLo
	m3+hKEuoMlubCDvgtypTVV6rQUlNudRYVMUY3NbyBEt+jaxpwqmYq5ZxXpepH0qsecZocfuyGnp
	Uy4SlhMxir1yDjJ91BbxCbq9Fg46KqjHyNnQQER2IHqvu+0YkDr24HZM/h6b6zG+DjtvumAjvqj
	vdr0r7ANEwz5IYK4W85AyEdVmGO7uEUp8YBeErgbsIEG6qpteqJESN5E35uP5v6KpQh6JuI=
X-Received: by 2002:a17:90b:4e8f:b0:3b3:a982:6e0d with SMTP id 98e67ed59e1d1-3b3a9826eecmr478799a91.61.1794849308712;
        Mon, 16 Nov 2026 09:15:08 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1887d7asm4464335a12.14.2026.11.16.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:15:08 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barry Song <baohua@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip memcg_proactive_reclaim when data lands in shmem
Date: Tue, 17 Nov 2026 01:14:30 +0800
Message-ID: <20261116171430.1008098-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <bbb07259-a2e8-40b5-9933-eb3d5d7a4bba@linux.dev>
References: <bbb07259-a2e8-40b5-9933-eb3d5d7a4bba@linux.dev>
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

Hi Hui,

Thanks for the review.

On 2026/11/16 11:04, Hui Zhu wrote:
> Would it make sense to turn the silent "return false" into an explicit
> assertion, e.g.:
>
>      if (!ASSERT_OK(read_cgroup_file(CG_PATH, "memory.stat", buf,
>                      sizeof(buf)), "read memory.stat"))
>          return false;

Agreed, a read or parse failure will fail the test in v2.

> Small nit: a one-line comment on the threshold might help future
> readers, something like "all-or-nothing: the data file is either fully
> shmem (stacked tmpfs) or not shmem at all (disk-backed), so half of
> FILE_SIZE is a safe midpoint". Also, printing the measured shmem value
> in the SKIP message could be handy when debugging odd environments.

Will do both.

v2 will also address two points sashiko raised: memory.stat is not
force-flushed, so right after the write it can still read 0 on machines
with many CPUs, and a shmem-backed /tmp should fall back to "." instead
of skipping. I plan to poll memory.stat until the write shows up and to
try each candidate directory in a cgroup of its own.

Thanks,
Kurt
