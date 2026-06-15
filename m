Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AF1494A8
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532794; cv=none; b=VRIWSrI17bTHaX5tJY4uCbtWkjqqWb4nXT7kENcnkKqfP+G1bFr6jeeoibaIsfrKzrEnY8eV5foV/wt7KCGa87U/bwvrj9X6iih2Q80pPzA2TgMnxn0GewH022bJBh0qCx/G9izpG66CnEkJBYpKARq7+go5MfhO6Mx9vSPkhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532794; c=relaxed/simple;
	bh=z1Pf0308GIXx35y7zNiQ26Q7XW1IEbgheztWcG9jfRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW6/MVQa6QE4ZjbmPO8DPfkjx/xxwnvXD/lCAhOQFkFNbxCseoYqz1EVCzeYsJ6GKlzsQnLg7wbnAdoLfuh4AElPbjdopvXxHpzKYlvXYpxg1ohyj3pqfxBvmDlZiBIXTVujZN6uxBb4X4nU1UOTbix5Jb3atHauvkxKqyraD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=or1c+1i6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or1c+1i6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4600cbb06deso1927186f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532791; x=1782137591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TE4i6DUnxedcuW81EIQxjbJU+HuCPuqKLHr71bT1zRk=;
        b=or1c+1i66zFnNks4yOGzwjjIlIA/Nc33hvxyznbmaE6X/+v5vzOJ7jVHPUtilgbgyr
         4xgKXGTlvq9+fhvD4TkKRISuFSdjOvzObnsFn7EImpw+Wn9/g1s7vEsItxaT/26u3Oze
         4tPiZiY8i3EQYeGRu+2K9oEzaWCFs8XKv1dA9O141SgqD+fL3ygJ2DB8shDuF8CdjAkb
         dZ233RjnnMwQ+TpmnceCn4oOzfHB35M2T3/vW+UID9NCMFdK2sFqGS+g45Ejes72lUXT
         e03GuYVY21FxAeCZfUPSkcrr12FCw+1n19gf+DhBa1JAU4ekVpLK2QBQ2ko0SW8A9Ap3
         6O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532791; x=1782137591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE4i6DUnxedcuW81EIQxjbJU+HuCPuqKLHr71bT1zRk=;
        b=G2HygsMf6AIW5JzKblJdG/GqknqFaqLgaJI9TQhoiMFxne0L0pYxoR9ydmDf+FUcUL
         uJnTQWjKVuZSJ7cPIDk0d3XK0ULvqXTIasTtG2d+pRnsz797qQBVjGY5Wbx/VEikavck
         whmm9gWu4Q1LWhYWFqvrdKmMdRJYdJ/T+a+nY+21zlGKQFGXMX2/AMpXm7e4iCGKnlzc
         mOytC6ZelcTJMmY2OT/AxUxCYGnWUYCbZfeGYm9aef0oXsG0k7hGd0US6GXxLTg3mzFK
         zUwmmt7G17TS7DWtm8tLmFR7g4q7MjNeiUS3wpGhyM8PvzlDt5YeeGdNOTBJ1XVhZte3
         F7ow==
X-Gm-Message-State: AOJu0YwtW1+zt30u1dXnZMnoB/x9U7DaLTQjmYrgIG2a43LPt9na+YcI
	tx878fo4e01h4RgAFsmQbED9wGECowoGjSpucZjzdhEcA2Tj4PQHpna4
X-Gm-Gg: Acq92OFarO6dxOUZknjg69BCvsxzMSb1c8Wcyc88VbWCwhPnBU4cy+/Eviz/6XK2BYs
	c0DGPXYiXAb3QuVBFiIxV2z87qcV4a6BauhtXk7YcR+MhmuKRtqMi6nucqiHeB7FVfnlr8OZtxk
	wXNJkI+0Jz+svVrigBxVJh46uO/HCAkI+UWe7bhlO8tMw4NoTWJcy4EaR/BfnRfDWLt6oyUHI/r
	rAKmxI/jiq0OFOJBdYl4p3Ky62an8E1EiscEjjQBHIIuUaw4+beaslk+VJDWUCM6rg4V8p6rCAW
	Gp6sR+iz3KZJ+W0jYpCrHivmPNZft9oMDbLO+0w9zubh+lPs9zs1NFJ1IqolUwm29dwpZEpgN2g
	6jG8EYUaGZgJr9p9D9sJWssI4CLWSG/1OLswWfGGBtBzgEHssIC9uo9JOcKkw7oHQPe+ZyVGY2m
	hYKh/afCX9pbuKJFir/bUrbUrmz/0Q60eD+KRsWELPIC5b6gN1pN0rgIapEsZajUC36JpeO8u9+
	Fe1djONtDNRuPwr/iupiDDE+/SX9naqVludUPya/3BQlkVEnU56/x2+am+uIbX7D0VL/+w5FAkO
	nYQBn5JhDTjhbLwXI4gHX0RIyZBacC8V4dPYaO6Sj8c=
X-Received: by 2002:a05:6000:41e5:b0:45e:8edc:dacc with SMTP id ffacd0b85a97d-4606d03bf34mr18432871f8f.27.1781532790867;
        Mon, 15 Jun 2026 07:13:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f20e77asm36900828f8f.0.2026.06.15.07.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:13:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:13:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear
 skb test_run output
Message-ID: <ajAIdJHvvIH9ZSrM@mail.gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615073856.152479-3-sun.jian.kdev@gmail.com>

On Mon, Jun 15, 2026 at 03:38:56PM +0800, Sun Jian wrote:
> Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
> data_out buffer.
> 
> The test verifies that test_run returns -ENOSPC, reports the full packet
> length through data_size_out, and copies the packet prefix into data_out.
> The test uses a 100-byte data_out buffer with a 64-byte linear head, so the
> expected output spans both the skb head and the first fragment.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> index d7f83c0a40a5..134be0ea8ed7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> @@ -3,6 +3,39 @@
>  #include <network_helpers.h>
>  #include "skb_load_bytes.skel.h"
>  
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_HEAD_LEN 64
> +#define SHORT_OUT_LEN 100
> +
> +static void test_nonlinear_data_out_partial(int prog_fd)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct __sk_buff skb = {};
> +	int err, i;
> +
> +	for (i = 0; i < sizeof(pkt); i++)
> +		pkt[i] = i & 0xff;
> +
> +	memset(out, 0xa5, sizeof(out));
> +
> +	skb.data_end = NONLINEAR_HEAD_LEN;
> +
> +	tattr.data_in = pkt;
> +	tattr.data_size_in = sizeof(pkt);
> +	tattr.data_out = out;
> +	tattr.data_size_out = sizeof(out);
> +	tattr.ctx_in = &skb;
> +	tattr.ctx_size_in = sizeof(skb);
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +
> +	ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
> +	ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_out");
> +}
> +
>  void test_skb_load_bytes(void)
>  {
>  	struct skb_load_bytes *skel;
> @@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
>  	if (!ASSERT_EQ(test_result, 0, "offset 10"))
>  		goto out;
>  
> +	test_nonlinear_data_out_partial(prog_fd);
> +

Maybe prog_tests/prog_run_opts.c would be a better place to cover this?
test_skb_load_bytes() is meant to cover the bpf_skb_load_bytes helper.

>  out:
>  	skb_load_bytes__destroy(skel);
>  }
> -- 
> 2.43.0
> 
