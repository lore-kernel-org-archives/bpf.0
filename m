Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222408;
	b=sxaCP/IsxJMK8NG79hgnMDsXFJdIpi06lPevN63p6PaxpqCgju3hHrbizX24klInY9Vp
	 c2edRwdSUxJ6+m8tLqOXfGi9yTOZ8BOSzU0oyC+b4nkI2rD22qsyEX+tqGyyEduWWL4U4
	 GP0HApJjgvtsI5r+B2Jqoogq5DbHVNvb6ELfGSztoKbXGvYsmINE1AB4p5qEJjR2vVU0M
	 ++wSMkcwb2Au/CDD8yPjRpd0yG3D2wMI5Zcma42F2kgR0tjxjfHWHXpNl1qX6OS/C+elu
	 q2Um32bvupUA3SWYEq6DXTeNdpmNdwzCslYI3QwFSUqTHJWyYooHDwL9llzYP+iTglQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222408;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=RMT+LSRcH2U/aAZrbwnmeg7rToD49oGh8uJ3esCEgaY=;
	b=WX5LBqgs0uCxub7k4/M5giayWf0CfUMLVDz1SiMwU4szP36tUM0q7DQMIgP/A+pX3ySV
	 4TYseRTJn/sm31G+kc8p1nbSn3i8qhVs+KoX/xU04+DCvxJKA7mk/xPN9R1NIe0mV82tZ
	 WdAAz8MICZ/oK+MktizG8wXZ9ehTtySDsK+ycOdUiie7My7T0iXtK4qPcKIT9wPZ719lk
	 lA9x7G5dBopLYoX9eZsLErZqEogjds4DIoHWzI+3ctONQUqdZNU7L/7JOt/A7Uml/lCLJ
	 wi7RWzdTZFNMdmKTzD2wup+mQwBIo8uAcXj4sQQZvYohzTxRpL+MJ8XIouPBYlrBBxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuVi01F0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F454606A696
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuVi01F0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6C1F000D4;
	Sat, 21 Nov 2026 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795222408;
	bh=RMT+LSRcH2U/aAZrbwnmeg7rToD49oGh8uJ3esCEgaY=;
	h=From:To:Cc:Subject:Date;
	b=TuVi01F0HS+fsxHWkLdN+DvgK52FOsdqbgJxX7m02A+1HSH/AfvZIvHOdaYuVdAqz
	 OVODgEvpyuBJH2Ip9R1aNZzw4E0irAwT6xZR+Of+NyIyQVvGQBCI+TC4091dN2iMpX
	 9BjONnsEyr6RS3iX81e04GavcEyn/Ib9I9Cwf2N0pT4WP2GY3aVTeVpVTkACL+XDOA
	 n6m7u2AzBTnh7gZ92RcNtmlBY+QP+b13W5SK2e0k8QR5E0NhjMdz9rEcTPKH+pzuN7
	 pslIU/S+9BysxPYWgNuKVKIrZUe1Vrp5liPZtvovEA9n/EgZJkKAfxhE57oog88m3V
	 RgSm5XFtvPMiQ==
From: Thorsten Blum <blum@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Thorsten Blum <blum@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH] bpf: Use isdigit() in bpf_bprintf_prepare()
Date: Sat, 21 Nov 2026 01:53:07 +0100
Message-ID: <20261121005306.942603-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=599; i=blum@kernel.org; h=from:subject; bh=S0CppLlZDwm781pUYgL2rwP5/MaCtROSuESY1VeV9SI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNkMr4vWx+yPWWgv0vW1QLTvwObbfL/chTqnis0qSTjp8 Yf/h8OSjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjImm6G/+nz5OO0HHwlSsT4 vM2ZWdc+9Uloqnln0rn8SUf0nmnt6xj+J80SlG65/Wz6hB9LS9IM/Orv5mh2+uZwH7ps7ydwyaS YFQA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..7292a15ffbb2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -927,7 +927,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			i++;
 		if (fmt[i] >= '1' && fmt[i] <= '9') {
 			i++;
-			while (fmt[i] >= '0' && fmt[i] <= '9')
+			while (isdigit(fmt[i]))
 				i++;
 		}
 
