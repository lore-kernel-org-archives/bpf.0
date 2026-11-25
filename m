Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575760;
	b=E8Ysvfv1Jxw5UEWcU6x/H3CMTwQHsT4kD4XHqm4iKSoxke7FOqvEfnOggCy2B+/92Ola
	 MwK3+miJSH8fHIboVNTgwq//UTGVEB7abFYMpIECkbNVQY+Rvjxcl7AuxlVHi3JM+gNlQ
	 2KdPymgBLs0Ux6pqK4FcyU+MMnAQBE1LhG/F0vrgmsbbrPF3TND4kBMMXP0Q9SkgIYiFZ
	 zdrtseoEJhCw1SdfOzdcafINli4Fb8r7XVx4B19FjoySxoLQvPFp6egjsg258cTkZRaYA
	 1kxCNVPAMmWS0H0PIGboac/gq5JxfcDmrGJyvF0dlT4jlg5ZUVsAYEV+R+uJrAZNFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Mj+S0OCJmwZBCexwj1UBIiBIBoUjlZPG6A8NDn0wRDc=;
	b=fTjPO4f6hddCyYsO+RTbIowHeUrGLzzhaVUPm3Kiv36l5GFvTPOm4w9gsT9sSpQV66Yy
	 ur4NSUpm2c4RNN1wlBc27QDKEU5mWWgF1lcASR7qiyWBitmR5ho7dLQfDU3xYUhrMKdcx
	 aNpuEkQ8HupayliXmuufNU1ArLvC7gb+N+cYByiaf77rFbHNROKHwD+mByT8fNOTR6SNy
	 8wjNI/kg0wpEVFPhdJ+l5O8A4oOtYa3SWzY0A1lwL9wXhDQaQlerpp8APJfMznRhTD2uN
	 LzF5GRhMjuhv4GAHxApC/Afh6HYMOzF35Qp0+Yb7LgpXUQPd6HPAegk6e3umV+mEINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCd2zNLG;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103F606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C103F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCd2zNLG
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso2046797a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575759; x=1796180559; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mj+S0OCJmwZBCexwj1UBIiBIBoUjlZPG6A8NDn0wRDc=;
        b=tCd2zNLGnXe27TOvg3Nsz35+Byxb+vmFt56s3OM1ujZaghvtCNHHsRIR3YgL2f76Gt
         qRAgSe7g8RVRytFGdJzCrBNQxJ9z9387sYot4IQUEAfqw9ixE9QBj6S+YbDQ+jLlEChY
         EMCGu6AK8SSZ/uNPZB96MBlT+/8o9Yt0SzlYEs7UL4+eB2bhnPJKt4obwaYlAZO5HkEr
         F4L9ZaayyXlejIj4ERqBQ9zZatOaT68JRM5VT5r0oRY4awazV3OAZqH7i4Kb5jbNkqan
         4eP76rCcqG1qt6TMRnhsJ31kg35lPbxjP9t0zzeSpX0k0AJBn6hDJGu1BhCvexrkE1Hd
         fsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575759; x=1796180559;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mj+S0OCJmwZBCexwj1UBIiBIBoUjlZPG6A8NDn0wRDc=;
        b=HSxsgZAPgZy19qe9qTueQ/nlVHjJfBzNFJAiHI2EKWZwkMqhVoDK9TTOUFYLfqupSs
         5B6jMrQhfjp/0CjXMBCx4Xrs9lE09VydGEApXUqOJnhA83IC9rmsEdeVre2HcDZNCTaQ
         feAr5ZnIZoKhLl0UadUCmztzsC+AY2mXrr4bWj9UCMlsvJhd4TqBycsJ6MyM3jXVNU5B
         kAcdV5rDpDDvATa3dIGiYi6lkHY80ShGfyjNNDjbpjMtUSjA2nSp2IRFmfug3Avi8tmk
         cQTU71tkCL2UfktN4qWYAvB0U28C2e/jt3mPvgH4M3YQegDUmqI9lJPqcvGYNgEB/M0z
         UUNQ==
X-Gm-Message-State: APuU4Z8NMZZCm/9sdnNoAXJ/DJtQR6gM4/VPS18VUwXdYzxpmyihteXt
	z6+4LG3as+1TLe/TDHyG6P5jMoHOKNpMBhmokWTZ5OCaXKDKfyZPjQXJ
X-Gm-Gg: AZFdTZdANo5cXwcSbc1x92wC34Cm2R3yASqcc844XEnVEvPHh2d+GOmsyoL3FusuaIk
	oUo9gor4El+ZBKvi9DxQgzlrf4FoeSspbSNwpQ2uEEgoDSfttsW0LdOxGBhfTmqB0aLD+bdCBu+
	ncA/qFNT8Y5aT4QNUYT336H1RJ4yhB01PqjYvM1WSjYEeXtHN+68+ad0KpZHPuAjou+IU7GVhw8
	6aQxlELBP9FcqfP6UpxLiLyknSoljTmk2pXuaDEJVbnL3avegZk0ga0liCjbw5ujQ9YJM6CckMM
	xfewSVMPDxD+SzuK2F5VhSmFjsvw0LVn5O4zEQ65omL7B8bzeiskc3TXby6b1ut/zDMEjNZzshG
	b2t36qyooqMK5tf+QHlEw3wz2yi2gJd3EK2LEuvI7/bGcLKjEODKKGCL4T8myIfnoy30nW8ZTVL
	X08359zSm32eMquGYezc1GCQQ/hTPInCy0aUMA+Ll5DcNwl8tX+y1T0HCuk+VBaMDMqa3OlqW5H
	5y5dSIkTat+9Yt52yYXAXlcDDdD5Lr66g0xC9WfYJ9J5AmS9+cDgvWuDaygucAM1VbApHh2BQCu
	rFRbSE8UwDxMXUum1/oui4pxbxg71QxaKkvPmoLUQrWZ3QxRMszvi6RiQEU1TcNobNIQXdnj6V9
	o3dPKEywoULVlG5xkl0x1zDDKQHCfUpdH+n6L8yvYWevRz6dyKbDvjhA=
X-Received: by 2002:a17:90b:4ad0:b0:3b3:cae0:2b68 with SMTP id 98e67ed59e1d1-3b41c95e7cbmr16230428a91.48.1795575758907;
        Tue, 24 Nov 2026 19:02:38 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm24999098a91.0.2026.11.24.19.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 19:02:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 03:02:37 +0000
Message-Id: <DN3YHFL4G7NM.36YOROLVGCSN3@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: Fix kallsyms parsing with long Rust
 symbols
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
In-Reply-To: <20261124-selftests-bpf-rust_sym-v1-1-32c450d0c4ee@marliere.net>
References: <20261124-selftests-bpf-rust_sym-v1-1-32c450d0c4ee@marliere.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 03:33 PM Ricardo B. Marlière (SUSE) <ricardo@marliere.net> wrote:
> -	char func[256], buf[256];
> +	char func[512], buf[1024];

can we drop buf ?

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index e871a26..06f6553 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -64,7 +64,7 @@ void free_kallsyms_local(struct ksyms *ksyms)
 static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 {
 	FILE *f;
-	char func[256], buf[256];
+	char func[512];
 	char symbol;
 	void *addr;
 	int ret;
@@ -80,9 +80,7 @@ static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 		return NULL;
 	}
 
-	while (fgets(buf, sizeof(buf), f)) {
-		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
-			break;
+	while (fscanf(f, "%p %c %511s%*[^\n]\n", &addr, &symbol, func) == 3) {
 		if (!addr)
 			continue;
 

pw-bot: cr
