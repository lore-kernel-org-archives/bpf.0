Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7229A309
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154806; cv=none; b=XRWCbsxqi14MGN1i4dV/ZScSInj5R5fEEHwhBS5LIsIubuMEEseNqcVQB27ZPKnDgrWhtZlqF3HgNoC6kukGvIlK/47TeL3sUyLHFBx4Y2/m33vpI7U8jtgVWNm3cuqLgKfcju4veFhcZPKcp7d6MUVQGQm0MQag0mPX0vUCaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154806; c=relaxed/simple;
	bh=kycoD6ocH1vvEHpxLfPNaz7rjOryPBvEeP6fbIKtITU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOc9K41mkVW3VoFHqMHWztWQX2IwVfQPzGmYE/Wy6RsgJL2g/vz2oGZZNobERfQFMdeflR2iuFh5m2DHfbBud2t5lRsfmoooDxkESmNs/xDkTlg6r1VS14n8co44Av0duDJem2Kr6O+CuH8Nft5NINn0GcG41Lv3EiGmX/mrN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TqoRk4zu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TqoRk4zu"
Message-ID: <d66bd191-f610-46b9-9721-61479d72eb32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NHklgCKhoWbuhsbY3mggoE+rsczXG1c68wkQEkwbmc=;
	b=TqoRk4zufGGJTsvZpUibKx+GcL12MeKHDrBU6edwGIVN1pVM3vj8v5WuOuG1hjD8HDdbh6
	KMrsStQTYRHGCY/njGR98gAJG+mxZEjg3Wccm8PYp0w7FfnHBDqlcSqKKq/fNvyaJZb96A
	qTnU9/qd2dDVSKPp7+x828tEeWenbvE=
Date: Wed, 15 Jul 2026 15:33:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 09/10] selftests/bpf: move bpf_jit_harden
 helper into testing_helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-9-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-9-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Move set_bpf_jit_harden to testing helpers so that other selftests can
> change the hardening configuration without re-implementing a helper.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v5:
> - check set_bpf_jit_harden return code in cleanup path
> 
> Changes in v3:
> - new patch
> ---
>  .../selftests/bpf/prog_tests/bpf_insn_array.c      | 44 +++-------------------
>  tools/testing/selftests/bpf/testing_helpers.c      | 32 ++++++++++++++++
>  tools/testing/selftests/bpf/testing_helpers.h      |  1 +
>  3 files changed, 38 insertions(+), 39 deletions(-)

The move makes sense, thanks.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d076..815f3e04540f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -227,42 +227,6 @@ static void check_incorrect_index(void)
>  	check_mid_insn_index();
>  }
>  
> -static int set_bpf_jit_harden(char *level)
> -{
> -	char old_level;
> -	int err = -1;
> -	int fd = -1;
> -
> -	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
> -	if (fd < 0) {
> -		ASSERT_FAIL("open .../bpf_jit_harden returned %d (errno=%d)", fd, errno);
> -		return -1;
> -	}
> -
> -	err = read(fd, &old_level, 1);
> -	if (err != 1) {
> -		ASSERT_FAIL("read from .../bpf_jit_harden returned %d (errno=%d)", err, errno);
> -		err = -1;
> -		goto end;
> -	}
> -
> -	lseek(fd, 0, SEEK_SET);
> -
> -	err = write(fd, level, 1);
> -	if (err != 1) {
> -		ASSERT_FAIL("write to .../bpf_jit_harden returned %d (errno=%d)", err, errno);
> -		err = -1;
> -		goto end;
> -	}
> -
> -	err = 0;
> -	*level = old_level;
> -end:
> -	if (fd >= 0)
> -		close(fd);
> -	return err;
> -}
> -
>  static void check_blindness(void)
>  {
>  	struct bpf_insn insns[] = {
> @@ -272,7 +236,7 @@ static void check_blindness(void)
>  		BPF_MOV64_IMM(BPF_REG_0, 1),
>  		BPF_EXIT_INSN(),
>  	};
> -	int prog_fd = -1, map_fd;
> +	int prog_fd = -1, map_fd, ret;
>  	struct bpf_insn_array_value val = {};
>  	char bpf_jit_harden = '@'; /* non-exizsting value */
>  	int i;
> @@ -291,7 +255,8 @@ static void check_blindness(void)
>  		goto cleanup;
>  
>  	bpf_jit_harden = '2';
> -	if (set_bpf_jit_harden(&bpf_jit_harden)) {
> +	ret = set_bpf_jit_harden(&bpf_jit_harden);
> +	if (!ASSERT_OK(ret, "set bpf_jit_harden")) {
>  		bpf_jit_harden = '@'; /* open, read or write failed => no write was done */
>  		goto cleanup;
>  	}
> @@ -313,7 +278,8 @@ static void check_blindness(void)
>  cleanup:
>  	/* restore the old one */
>  	if (bpf_jit_harden != '@')
> -		set_bpf_jit_harden(&bpf_jit_harden);
> +		ASSERT_OK(set_bpf_jit_harden(&bpf_jit_harden),
> +			  "restore hardening configuration");
>  
>  	close(prog_fd);
>  	close(map_fd);
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index c970e7793dfc..737f668b35e2 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -519,6 +519,38 @@ bool is_jit_enabled(void)
>  	return enabled;
>  }
>  
> +int set_bpf_jit_harden(char *level)
> +{
> +	char old_level;
> +	int err = -1;
> +	int fd = -1;
> +
> +	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
> +	if (fd < 0)
> +		return -1;
> +
> +	err = read(fd, &old_level, 1);
> +	if (err != 1) {
> +		err = -1;
> +		goto end;
> +	}
> +
> +	lseek(fd, 0, SEEK_SET);
> +
> +	err = write(fd, level, 1);
> +	if (err != 1) {
> +		err = -1;
> +		goto end;
> +	}
> +
> +	err = 0;
> +	*level = old_level;
> +end:
> +	if (fd >= 0)
> +		close(fd);
> +	return err;
> +}
> +
>  int stack_mprotect(void)
>  {
>  	void *buf;
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index 2edc6fb7fc52..e00642afe86f 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -59,6 +59,7 @@ struct bpf_insn;
>  int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
>  int testing_prog_flags(void);
>  bool is_jit_enabled(void);
> +int set_bpf_jit_harden(char *level);
>  int stack_mprotect(void);
>  
>  #endif /* __TESTING_HELPERS_H */
> 

