Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41365209F43;
	Fri,  2 Oct 2026 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921635; cv=none; b=iDAF/8EkhmSP54mqjYAbCJTQGalCGntG7ND0WcMjjalSuaQbrV8yOYEmttJfxuYAexH7sZ3ITUYaSDuQvXbJUVDnYq+m8rZhkE4ZzPZt7K+mgo0+xhdCJIRX+bb696X0E30TtAY0YPuURHoq2ne1SsmE8aYxFIh3++KwemFC/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921635; c=relaxed/simple;
	bh=toIV5pikIjy/aeaBVCIwei1YNS9X/1Zuz4slJobj66s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cmQwsg3etPJPHJRz5CJ1Y0fRemIpjZpIDEWn/QmQx1Q/ymOEo37HDmDJtu+Kio6CBeC8pFbkCtI5Yu57hv3lT+hesX24W5l/ghzFZyTLm3Xca5B6GqFTr/860qhXU6nzpU48yiM3KL4+7AsBD7vNN5D4Y8ejNlhQGSb88TbrboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrSSVKNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrSSVKNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978B71F000FF;
	Fri,  2 Oct 2026 06:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921633;
	bh=mdrSFZDaDDzyO0ZK19f3S/LIaZl1zCC9/6iWft1/JVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nrSSVKNP/6SA228jiPe979ixC2f4fi0n5XZZJn+pqEaMvKXywK9sFZTecVyLGxUnt
	 OTyR16FV+O6qzXdNXFeDfTPb/T4/IXlsAnIgXW3HpquWbHe/N6ju2ih27pJWhk5qCF
	 ypv2mqSW2urD4mI2ly1YiucV3DJnzSHzZJBudWbAoiKq8nO/wP4lSZs28dgXwFqgHV
	 ycY3pZnXz4hsq/lxteyjj2ENit9szkX7bNtbmxaqNzP3JkctXgzOzjkh3VVqu4zifu
	 lW3vX+QOc2ZgMJyfL3nodyPYP5SbJX8rr3cpOkbSA7zQ5XWZVVq9ZHFMS5UIaOEUFY
	 gVXqR/qs8Jkjw==
Content-Type: multipart/mixed; boundary="===============6114460815882526170=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37328eed3277cd2e4ce990db3029d5e626f896011ee344943011726d70b1bcd8@mail.kernel.org>
In-Reply-To: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
References: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add XDP test for per-flow LRU_HASH window updates
From: bot+bpf-ci@kernel.org
To: anilkaushikwireless@gmail.com,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org
Cc: sdf@fomichev.me,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,anilkaushikwireless@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 06:13:52 +0000 (UTC)

--===============6114460815882526170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add XDP test for per-flow LRU_HASH window updates

TL;DR: Nit only: the comment in the new xdp_lru_window.h is overlong, repeats
the commit message, and calls the shared header an "ABI"; suggests trimming it
to one line.

> diff --git a/tools/testing/selftests/bpf/xdp_lru_window.h b/tools/testing/selftests/bpf/xdp_lru_window.h
> new file mode 100644
> index 000000000000..78434045cf11
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/xdp_lru_window.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __XDP_LRU_WINDOW_H
> +#define __XDP_LRU_WINDOW_H
> +
> +/*
> + * ABI for the XDP LRU rolling-window selftest. Existing test_lru_map
> + * coverage never enters XDP; XDP parse tests do not store a modulo
> + * index into an LRU map value.
> + */
> +
> +#define AGGREGATION_WINDOW	50
> +#define XDP_LRU_WINDOW_FLOWS	64

This isn't a bug, but could this header comment be trimmed down?

Most of it restates the first paragraph of the commit message and describes
what other selftests do and do not cover, rather than what this header
defines.  A statement like "Existing test_lru_map coverage never enters XDP"
can go stale when another test adds similar coverage.

It also calls a struct shared between one BPF object and one test_progs file
an "ABI".  The neighbouring shared headers (test_tcpbpf.h, test_tcpnotify.h,
xdp_metadata.h) do not carry a comment like this.

Could the coverage reasoning stay in the commit message only, leaving at most
a one-line note about what is shared between the BPF program and the test
runner?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36971050072
--===============6114460815882526170==--
