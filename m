Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501112F39C7
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349861; cv=none; b=rALBGl7UeHjGxdo2neveXgGsZFHdVXSu6GEj02daKWs0LrTaodmNjDhR6qyLgbHmIPtZKLCo9NaIqXunqJhynuirGZ207C0+rs4wS5jDpb+G5JmBep+IR7hWNKfnejX2p4I5NSgH6eorKufDvuXLDeI0d0EJRaC4fZLA8LYFzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349861; c=relaxed/simple;
	bh=yBhbYIh2Ju5tQDUgHZTv0vSHzCYYDKRKZcgbwjPtQpA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ASL3aCxKpR6D5HXODQWFXwb62BivOcU2m8BecPILq1N9dibmThX/qYszeXB1Kgmmkr462gXssPJlLWNQEmBKRHVJliNU0cHkzON2l24rccjKV1EUBk1PM3eiROTymwcb6fIi2YOcvLpM/fgQDyJl4OrKvLl9dvduCdbCoJn+irk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHajzusv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHajzusv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CFD1F000E9;
	Mon, 10 Aug 2026 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786349859;
	bh=OUVmScUGvlJ7eyg8Cczhspu7mbzfoxd2WjvAgFIebnQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BHajzusvkiD4IeklN1bolsllYZxuYoRN4szmTyCWYjt74FiTXu4QkkK/pQRoytc8M
	 gXSnc0BVMqPLpD5JDbVDoz8OuavAe2JwL6AKgOYlQ0ujnwlfU0NR9qKbJoBfahAhGE
	 sUXXlbWN1Fi3hG1SWgSI9eh4uxUiVAr0y70iv/fWbYRoNfBLW2yCv6n79lwzx87D1c
	 fm11b7LlpJtoqs+6mn1+5HX3S7nz1pxqc7+yXzV2Pg9h9HY2iawl2mDxNBb69Gk2oS
	 a74Pi1vOcGe746WodFXiPmntypkB8BOTkes6lfW4nq9oBUL/856MP1Hnn7/+zPJqMz
	 /HFYRlwp44upw==
Content-Type: multipart/mixed; boundary="===============3713297704686120614=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <559fb46f069bf2f5719e9363f2c569b5a98935ee3f10280c7991aef96cbd7ad9@mail.kernel.org>
In-Reply-To: <20260810073348.2586225-2-chenyuan_fl@163.com>
References: <20260810073348.2586225-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: fix double close in map dump
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 08:17:39 +0000 (UTC)

--===============3713297704686120614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 6b9649294ca1..e9f4dd9458cf 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -895,7 +895,6 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  exit_free:
>  	free(key);
>  	free(value);
> -	close(fd);
>  	free_map_kv_btf(btf);
>
>  	return err;

This isn't a bug, but since exit_free is map_dump()'s common exit and
the close ran on the success path too (and the break path also
double-closed via exit_close), would it read more accurately as something
like "map_dump() closes the map fd on all exit paths, and do_dump() closes
it again"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31367518511
--===============3713297704686120614==--
