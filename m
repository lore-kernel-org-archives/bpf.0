Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E82EEE83;
	Sat,  1 Aug 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785598093; cv=none; b=OR/iR6w5PwQnNqGI94LpfqBhUmBbxlnHRlL5YBGxA2VSFCRoBL/onULa9OBsfM0dXbKZj1y3KhTxXkc8/RF+V15BesAWkIeqpt40OL73VUnNjZxP+5bxJL7MAYKj2eql9e7MucBWGTBwi9sntFTeVSURhgZXNeLbVmhHBjjsfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785598093; c=relaxed/simple;
	bh=oOCqQhfXPOVCryV2Lyh1eQbDjUpPGnUyoC14TUPeRbs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cB5i+RmM3d0Hr7rcBk98vC8i4Ab0Ch4LFAi4nF6w4w2aoxSF/FeQRJBiGPjvwQdMFwhVwUHWuDck0yQJ0Qal8X+JYPsaJX5HmXhtRK2XdXrTMKvI1PttBi0a1Qh4WH5OIFVT8NkVUKZFQBCeDIr9VZX/76ZRn/zynqf88QaRo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgExd5Bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgExd5Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279E41F00AC4;
	Sat,  1 Aug 2026 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785598092;
	bh=vQBoFghzfvbIk4t7HfByUhUzNqYPUi4cpok/xmE4ddU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BgExd5Bd5QBPfHCYiX+hsdzed4fn1s6lCBMgil2EzvFgjS3SMxBo0h1DCVILO9Yvh
	 j5/KIn7fnoGWzBVafOvGRz/m5ujJNAIMMm44kmpHmQHQRX3rmNfpdWnu6Lxwp7mmwK
	 v+/1dM2MqL4soQanFtImQVaekYfX3+YWrSB/zQSxKkdKGGh9z2YHiODuwZ3P6IcrE+
	 R9xoh5zCEif48sANM5eiQU1Dtl0jARAXbLJ6sjWYZ4eMIlOBIbYTRl4j5+WAKHEVOj
	 MFxEo/ScstqlbsWUU2G2Wyb67G9Bb6cqd/8HIwNc6AdYxtnRBnxWEn+tM05u1kVuO7
	 Iq/URyi2NlMXA==
Content-Type: multipart/mixed; boundary="===============2062672385804050509=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <718d22ac66d4e170dd1c7ff31af024d887cfedd39f951eb0ea368f1e71079b42@mail.kernel.org>
In-Reply-To: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
References: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
Subject: Re: [PATCH 1/1] bpf: Check sk_fullsock() in bpf_tcp_*_syncookie
From: bot+bpf-ci@kernel.org
To: enjou1224z@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,lmb@cloudflare.com,vega@nebusec.ai,rakukuip@gmail.com,enjou1224z@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  1 Aug 2026 15:28:11 +0000 (UTC)

--===============2062672385804050509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Does the Fixes: tag point to the commit that introduced the bug?

Looking at the history, c0df236e1394 (v5.10-rc1) widened arg1_type from
ARG_PTR_TO_SOCK_COMMON to ARG_PTR_TO_BTF_ID_SOCK_COMMON so that
bpf_skc_to_*() results could also be accepted. However, passing a
mini-socket was already possible with the old ARG_PTR_TO_SOCK_COMMON type:

At 399040847084 (v5.2-rc1, which added bpf_tcp_check_syncookie):

  kernel/bpf/verifier.c accepted any sk pointer for ARG_PTR_TO_SOCK_COMMON:

      } else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
              expected_type = PTR_TO_SOCK_COMMON;
              /* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
              if (!type_is_sk_pointer(type))
                      goto err_type;

  and type_is_sk_pointer() included PTR_TO_SOCK_COMMON.

  bpf_skc_lookup_tcp_proto already had .ret_type =
  RET_PTR_TO_SOCK_COMMON_OR_NULL, yielding PTR_TO_SOCK_COMMON after the
  NULL check.

  bpf_skc_lookup_tcp() calls __bpf_skc_lookup() which walks ehash via
  __inet_lookup_established(). ehash holds TCP_TIME_WAIT socks
  (inet_twsk_hashdance) and TCP_NEW_SYN_RECV request socks
  (inet_ehash_insert(req_to_sk(req), NULL) in inet_connection_sock.c).
  The returned sock_common can be a request_sock or inet_timewait_sock.

  The commit that added bpf_tcp_check_syncookie (399040847084) exposed
  both BPF_FUNC_skc_lookup_tcp and BPF_FUNC_tcp_check_syncookie in the
  same program types (tc_cls_act_func_proto and xdp_func_proto), so a
  program could chain them from day one.

At 399040847084, sk_protocol was still a bitfield inside struct sock
(unsigned int sk_protocol : 8), far past the end of struct sock_common,
so the slab-out-of-bounds read described in the commit message was
already reachable.

Should this instead be two separate Fixes: tags, one per helper?

  Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
  Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")

The Cc: stable@vger.kernel.org line will cause stable tooling to backport
this patch only as far as v5.10, but the out-of-bounds read exists back to
v5.2 (bpf_tcp_check_syncookie) and v5.4 (bpf_tcp_gen_syncookie).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30703540639
--===============2062672385804050509==--
