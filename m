Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235667;
	b=K7xMS4AHB489AoG55JGbADXH1LuAPbgvbhZUM7DgvMJ2c0yGY9VoFr8PVM5mS6RQZsZ5
	 aaUSn6QGvbKw165uKjRGujDgukTJPPxfLDUZ+PZ8iuViA8xY6r+MDAvknGxm0386HS2xa
	 ByMsKzyhhWb2047F9FSkwxIz44aF6rOMEwJ3CdK+376A73oyOk8ExHPpgGtvGVFN6InoF
	 MCiYY2wrUbxplLpPOm3p6jQr9R7+tHX7SENV/FbLrf2333uMjNWQ6tPAsMp7QCaeqhmcC
	 Bi67yr+5N5Y4EWn7BKTD0uxfaxKACBZVoswIp8Db0PAhFZtVsIxM2Vhjzkc2ec0x4wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235667;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=w6GLXknq6y3SwqceXuYTD6xHKDaefkjVOMui140fNzY=;
	b=BOlGz6jv5iDRLXvErWhUhWZC9CdD7E71GOqM+PbIYBO1I7Cl3Llc5K746Ag5rHA4ejs1
	 DrOyfa8HsacQb7e2U2cvWcgl6JFK1i7MFBjPfgpAGlErV15aQR0xmb/MfmnxclAcy5B4x
	 pLdrLFS2XapPGkwERUGr0obd6JVvjMq9eh7PfXGiQ1QtIOKbp3prClBODrCIj1d2z72FG
	 398Qf46+OFxWB8p30SOdbSuwLRttjCUmRrQwjyHpSkRZM89ktuGy1TTc/M/lTXX9hFCfC
	 dLwm2W/I0i0XUdkdQ8WiC+4FYAyXbvqd2B9FwI3qZNa78Kypr4uAKFkXdkYxSLOkPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecFGce6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4538606D825;
	Mon,  9 Nov 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecFGce6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DCD1F008A5;
	Mon,  9 Nov 2026 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235666;
	bh=w6GLXknq6y3SwqceXuYTD6xHKDaefkjVOMui140fNzY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ecFGce6Hq7THGpXfX2jQytVd1Hy7TmpGWK+zuQkrhErR09GUy6Fd3/pYslpSPFN9W
	 Pgar2X481Za3BS2faGbic0LtVTplhB6mS3PZe43jbZaRdYjCRJNg9AbzaUJug5oVyi
	 49DFwMKpVSJT6YjvVuxjWJR7z9AJWqZMC9dxuiz8uhOvHrihFmkwPpuqgpVIYtxZWd
	 TWQd6PbZB8D8cPChdmFHAz7P46cfIXLlyf9e61rs5t9pubmocX913zkhKQT4sGQqZG
	 pDgixCLa0fZDpFw33sDT1jNn+BMosgXqTy44qDWK4PcmC+ADX5fYlqsoroHmlrzABA
	 XYf0sPqB0RuNw==
Content-Type: multipart/mixed; boundary="===============0931968269646556687=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <11d1648e59b112236d1add138094b2c057d19270ba45e0fc47f6342da665db95@mail.kernel.org>
In-Reply-To: <20261109140816.5196-7-leon.hwang@linux.dev>
References: <20261109140816.5196-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 6/9] selftests/bpf: Verify tracing link_create logs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 14:47:45 +0000 (UTC)

--===============0931968269646556687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Verify tracing link_create logs

TL;DR: Test issue: the invalid attach_type subtest in tracing_link.c may fail
earlier in the generic check, so it may not exercise the new tracing log.
Using BPF_TRACE_FEXIT on the fentry program might fix it.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c

[ ... ]

> +static void test_log_invalid_attach_type(void)
> +{
> +	const char *msg = "Invalid attach_type.\n";
> +
> +	test_fentry_link_create_log(0, 0, 0, BPF_XDP, false, msg);
> +}

Does this subtest reach the tracing-specific log added by "bpf: Add log
support for tracing link_create"?

With BPF_XDP on the fentry program, link_create() fails earlier in the
generic check:

    ret = bpf_prog_attach_check_attach_type(prog, attr->link_create.attach_type);
    if (ret) {
        bpf_log(log, "Invalid attach_type.\n");
        goto out;
    }

For BPF_PROG_TYPE_TRACING, attach_type_to_prog_type(BPF_XDP) returns
BPF_PROG_TYPE_XDP, so bpf_prog_attach_check_attach_type() returns -EINVAL
and the case below is never reached:

    case BPF_PROG_TYPE_TRACING:
        if (attr->link_create.attach_type != prog->expected_attach_type) {
            bpf_log(log, "Invalid attach_type.\n");

Both messages are identical, so this subtest would still pass if the
tracing-branch bpf_log() were removed.  The generic check is already
covered by the invalid_attach_type subtest in xdp_link.c.

Would passing an attach type that maps to BPF_PROG_TYPE_TRACING but
differs from the program's expected_attach_type, for example
BPF_TRACE_FEXIT for this fentry program, exercise the new log instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300
--===============0931968269646556687==--
