Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542276;
	b=UChA42VLhF322SVSH8xcsLdZhn+mmp5JI3Z92gmgicdCKXveLzsWFBdnqvD6bCYBygPr
	 A7HFbB02ppV8PzLr3UeU4/toaSt9k5T6EqqFkJubeU6ByyZLLRZqHVit7zCqnAQn8xvr+
	 ahEfwD0MyT6aDEa6FiDH0PLblNjXGLBpFt5KERHS+rwBKYgz65h3mFHNwEh/0AOuK/zxb
	 iBJBxskmCD9zUsYIZXl+rJv8nXahAr7IOe7au5ZRAZ1vn2J+6BM1PFVHg299CuX+7O03L
	 u7b01TVTqZnslEbQzOQfYJ9RbIS1SpHs3bl5MqaxBfvAncmlt97X6Tn0XLfEvZm0xGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542276;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YhVqg52B2nZp03VrysYZ+W8geydfhkh143H/+zCmEt8=;
	b=prhTT6nj/QsYbk04+WMmkSHdwytFT0diKEHrWrRc/Jic6XRh+smJgFBHhGioD6D0FN25
	 OAqWNUA7QBvlAEHGEZ26bz9CGSVkGUbOG4Vw9lM05EE3w3ETlyU7aRlLyM2hZ9nV0jJCS
	 6Ye3qJ8+wSEfovX+jZAsMHZhy5y7mRnlevT7TTa6eK1PyH3SH6PXVUHb84QYs2gc0DBDW
	 nRujvNakSqPfcQM8OiN7ekqYutkslvEuQfIcHl723aO4lTLwN60GoewgfHClgVukF6I0J
	 5XZ5261PcjQx5xS0mw+ot0ucybPV9F44ajm6vTG6sLU+/5XNO1hl7lvJjFOcPixeX2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0V97Zp2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9A606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0V97Zp2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5961F000D3;
	Tue, 24 Nov 2026 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542275;
	bh=YhVqg52B2nZp03VrysYZ+W8geydfhkh143H/+zCmEt8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=O0V97Zp2fMBxDlBtUkmF+ziWAWhnYs5v59v5H2/Ob31O9hLney6oIvnGJ6kuvMSlo
	 VgQ4ONDBYJ8E7DjQxs+fskuQGyKi5N6I4KiIcnSkpj+K1VqEo8k7YJG2w7I18JlpeV
	 fEoWZ2fzmnbvIZjDqQAqvCob0yaEJDYC6DnC1vXzZaTtxIpKDRUzS9YXyysMuqwiBt
	 9rueetd+CXmta5NjVO1wptz6ccBYo7Ifz+5mY8y9COrAS0T2kkLzzSFwNmGNgS8jk8
	 j6qjnlFZgxLmpEaoup9Z5hkMfVxiEd6pZE/xmyObo6QnogaiSa7QOtQQgXeT6to6l8
	 QBqzxUaCx9+FQ==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v1 10/10] selftests/bpf: Add tests for the
 ring buffer record API
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <107b5d4cfd8911f388ccfb2cd06e08185f1bb60c.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <107b5d4cfd8911f388ccfb2cd06e08185f1bb60c.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.12694484066366043593.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=tamird@kernel.org;
 h=from:subject:message-id; bh=Ej5k/9N82N8UcufXFkiwhfDNojfyurKH49QyT9fRSwU=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz53LhQK96oJW//soYTpxbdvtrPGdnSumD3xVI2S2
 uFL+wMPdkxkYRDjYrAUU2RJFD20Nz319h7ZzHfHYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdAx1jBi5OAZjq4jSG/95HfX2PnOzQ4RAy4P1Z++DVf7nw9+dP8N+UYqhYMMvceDsjw7zTO9J
 zmMQOWv6JmNG8JuLCpMdzGY9xnNjnEv5gU1VENB8A
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
> new file mode 100644
> index 000000000000..d416bb19d101
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
> @@ -0,0 +1,586 @@
> [ ... skip 371 lines ... ]
> +		/* All records before the first one that is left were overwritten. */
> +		if (n++ == 0)
> +			seq = lost / rec_sz;
> +		else
> +			ASSERT_EQ(lost, 0, "lost_bytes");
> +		ASSERT_TRUE(record_ok(rec->data, rec->len, seq++), "rec_data");

Could the fixed-size overwrite cases also assert rec->len? Returning 8
for every overwrite record would currently pass: record_ok() only checks
the reported prefix, and the race test accepts that length too.

> [ ... skip 87 lines ... ]
> +	test_ringbuf_iter__destroy(skel);
> +}
> +
> +struct race_ctx {
> +	int prog_fd;
> +	volatile bool stop;

volatile doesn't synchronize the worker's read with the main thread's
write. Please use relaxed atomic loads and stores for this flag.

> [ ... skip 11 lines ... ]
> +	int i = 0;
> +
> +	while (!ctx->stop) {
> +		args.size = sizes[i++ % ARRAY_SIZE(sizes)];
> +		if (bpf_prog_test_run_opts(ctx->prog_fd, &opts))
> +			break;

Could you propagate this error and assert it after pthread_join()? After
one successful batch, next_seq > 0 can pass even if this exits early and
the rest of the run has no concurrent producer.

-- 
Tamir Duberstein <tamird@kernel.org>
