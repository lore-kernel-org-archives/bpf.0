Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAA30C621
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108351; cv=pass; b=YDjUX8rzmfgnRMU5vTH7h7fEgkhW08S806peLY7mBXMKiTTCxp2RMPUjoI/LqfpHRDRmKbZoL7Z/LCDVM5THM0sNgHEgxxiAbxCc3xKzrrRzavL+FbBxpMcanCXQbsCtbg7oGQXeokBg58fQvEgZ2ciGlNF/nKEPOS1ObFAup8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108351; c=relaxed/simple;
	bh=k20f8t1EOV/HEyg7uqeU/OGvcbfXWsNUgp/Vg457HkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsebSQTrk/ZQAEG1qrut/xjLVJxT0mWWrp0X30X0cvPOtcX43OYAMirKKbtmNW4qpXhGhoRfsjZcYcsPzw6mI8+yxu+dHU6Q/69l6EJKjYZPRSmQ1vse+GpodhK/B8UdkSCqT65zWz/daVwiy7ISUjO8lCVz6e+Qtp4HyNR6ny4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku1WSM5Z; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku1WSM5Z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c5b40f60so5171471f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 19:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773108349; cv=none;
        d=google.com; s=arc-20240605;
        b=lP+jftpIZqEnq60bsZqBeZd6Tlh+2cVDO1n8NectsWAID1OlZD4DhQNARVTRlkry2c
         nQdnX9MkYkwOnPKNZnYsswc8eIX6FQmxVrEtHgyiKKxE1+GgHYxooVSNBMp5sxJZ5mNY
         o46bHteH71HY7v3Iy01bp0eMMswCkWWWQAY4U5o/AIKSylwmiFCuTnidGrlwrf9SYgUs
         r8oBh5veNn05Nhb0YxahLz/EJu9ilqpEgdj5DjGxvk3y+k593sO9/R5cuMTp+btKRWBf
         vZeAWPs6W3+056xTewbCT6X3uXfZlq54Hk7+yhwhKtYk+Fp495d5fHSU6rHEYlvoafU7
         uPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xnHQw4FSCYovPcBM7FdZ3WfrebkEeQSNBMs5Gxas3Ic=;
        fh=XRhdLwqrqRvMsma72DFkrWWa4NGtbOscb1NLwdTLQZ8=;
        b=S9ARA+WGOjCkmJZx5WKP1zv5NDXAUdhyXOdlvog7ddsg/kKzsP+WLyiEXTt910OS6j
         JkvNx/XLPosXMdSxWKyJZc59H4JpKxUJgqy3kO+9LG1aHTczA5aqoIFO1uaC5S8LjcvN
         +Oz7KfI4gLbI1wYMSDMBJU1E/PybzKt1Hxn3lv6hwrAhj3S6znd/gmiDoZqLhaKdd48y
         5R8m2iQ9/FxsECIEitqlokEjao0u7LY1XVJIOWkZKsmZChTJITJ4JJJ5SYtS3QmS3Bcn
         wM91ldtbzKRTE2wIVAXqK4rftBcUj7O/YSmFdqIbSMrb5Sc+kU0vMNPi3qhZababPXws
         LeiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773108349; x=1773713149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnHQw4FSCYovPcBM7FdZ3WfrebkEeQSNBMs5Gxas3Ic=;
        b=ku1WSM5Z9CA/HHlyScKafmWYbY9m+1kz0iEmj01TWtjN8oJwlJGbpc8OuKjqYkzFl/
         bMaj2VaaoFApYVdFrS5BYjdmGuGgdJrdDIP4gGYp5xFa7n66TD6Mf+P4ZEKmQEfEw9Cd
         yHTTft0NiYjU4Cgwm1VzMlCv4EDMSwua1mWGfvjT04c1sD9jeyNpndL7sWyvpKYvumBk
         kjvGPWeByC+Un3ga9Vam0wVvzdpzqBKjRLHVK2utKRxCac7ovTOso/eTg6Kh+Uwp+O7O
         t2wBVZpJ8VRZW8xdIEx0dX1P4hsGJs+aUJWc1sZkIkkytZ28l5G7yzp0XQWBTyfPguOM
         HuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108349; x=1773713149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnHQw4FSCYovPcBM7FdZ3WfrebkEeQSNBMs5Gxas3Ic=;
        b=cF1hZwe9cy+xGuZHyixtAmfVvVWZW+cqh30TvtnjVePtswGWvqVLYzzqnZpuvORoub
         EDtLRdCpPsvSjG6X6L585giIIOm9BVqbsn7fPd/Skt5pvlP+deOcA0hQnQ7JcS6jved/
         acB+x3pnhG6rHrQ19A7vw0hBOWOuJY9GgtJmvNRXbWoxvUBPZ0qk/cjpNu+clDYlqJlJ
         RRRS7v1BdH8B04IufcC7McTSx5kcr7eFWljqWvT8Qbi32B/2c/dFRWDSXe+w6tnv4ldM
         SJ7mE3gqQbCLP2xslbzinAf1RRpw8eYHChDG2sQSwUsU1vMqVTeMJZEp5nXkl5+p0zDY
         vtMg==
X-Forwarded-Encrypted: i=1; AJvYcCWPtFFMA+lJWzayXlRQmW4kpY51vSOTSwWgtNJRqrdzrFX3O92TIyVTaKanZPPmNbl2JGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAmG885uOY9ZbINVooN6TB24MVv1zO66cXCfJ5DKfiA9g+0JB
	ziQIAQkjGM21G+mGm+ZjqVWQzf9ppnk6LgCQrbb1I3UguEdyNczKofqlcJQRSkj3mAmCW0TVDCj
	HTjSE7ZB8HQRyKZJ6VeppQhhiBzlaGEc=
X-Gm-Gg: ATEYQzxVjgj2G/BvhH0NpK+uQoBoHxJuYWX6XpB5tV89O8HTk6rBvCdFdPW1xcEG5tr
	KZ4fOkP+9yqZJQCCktHB1/WNn3a+nz8eoX4/m8RddvN6/twudBijIk/5hkIrXhZkUCIITHlwXl+
	dYJj3dapd9Oe0TeCD8pOtY+WuiEcaoQ3NyO7wel6IfOPocEw2Bz28HhwOE26BUzi+GnoUnpCeSc
	dQ/lLkm1NxMK6KD2oo8UxSt+7EZWifEFLBkZh9tLvtlPIjte5J5sma//3bJcoQCJ9FfJixMR9FF
	RduMSDoYo8XfAV59F9GhuoEBKPEL/MKCV1IqfWH9bOFKrmQ3iiS1OhxKgX5E3hr0yB8ULsv5b7u
	LViFlX5bdKCpYV5LYdl9oEc+2DA==
X-Received: by 2002:a05:6000:184a:b0:439:b81f:ada0 with SMTP id
 ffacd0b85a97d-439da86f76bmr24055151f8f.57.1773108348613; Mon, 09 Mar 2026
 19:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308134614.29711-1-pilgrimtao@gmail.com> <20260308134614.29711-5-pilgrimtao@gmail.com>
 <4f40d120-41d1-4723-a410-63d095d2b31d@linux.dev>
In-Reply-To: <4f40d120-41d1-4723-a410-63d095d2b31d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 19:05:37 -0700
X-Gm-Features: AaiRm50pGcnLkggy7DiI7dJTNRGaKrpS8VH9Vhnq0M5rsIFc9PhWMcBV-OUE32M
Message-ID: <CAADnVQLC7c+Spmk0VoatWsjA=ok-ofEOxp11L-C1DR+=GVCcTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Chengkaitao <pilgrimtao@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 11:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> > +long list_add_del_and_check(void *ctx)
> > +{
> > +     long err =3D 0;
> > +     struct bpf_rb_node *rb;
> > +     struct bpf_list_node *l_node, *l_node_ref;
> > +     struct node_data *n_rb, *n_new, *n_new_ref;
> > +
>
> Prefer inverted Christmas tree style.

Just to clarify.

This is not a requirement, but "nice to have" in a new code
if it doesn't interfere with logical declaration of variables.
