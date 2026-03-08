Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7D2571C7;
	Sun,  8 Mar 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772979907; cv=none; b=ED8F4INn/LaxZ2P/T71qgT+jfShvsZtuWot/NgDCxNTXjjr/u2T40IPgQckiNiDv7md26T7wCO07HtcrcNo9LkKHdpTFKdWd+51sNxhvdIJcBe3gRqoJcEsdi85k7Z09B9XevgBzLh8XxmIV7VwEglvW+5Ek/ACUEF7qWPwLMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772979907; c=relaxed/simple;
	bh=uh1EeE292PLTCe9B/9LtiAQDe0Cax1Z43OUF9UT+tDM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ueQuk776X9HAUdinN1V1QlxNDJFGg49KHiOMeUpFifWllljDpG4Nr/H0dbGRIh3ZLAiHqktAleSyrcmbp1whAecKF/2Fr+ytFw+COhQaaivHxpHrv8JWkPtYC2Cc+YchMvZyGGKVVuk+f1jTw+iazzU8fOASAAx7P/sM35+dBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrCkdYM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrCkdYM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79795C116C6;
	Sun,  8 Mar 2026 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772979906;
	bh=uh1EeE292PLTCe9B/9LtiAQDe0Cax1Z43OUF9UT+tDM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OrCkdYM4eowvV1nhQ0mG7j/SEuxuZrMhiV6EMVT/bqtEI9qvJSdzp+4sstns/eyDA
	 03O4KvzxwvSXU2KIo5OVJP0wJoX2ZA0tkS31JiqQyjDvkA3bd01loSbBs3T5f5GmiH
	 ZEQ95+QUZzmXZlomK609iwGdrRX+hKVhF634D5990S/4X/u268HJerJ4UZyNW/6zUT
	 Fhjyhc8epHck8zraYBGIAdSfjZOfugqC2RYN75uPIotjdcWrnGp5xV5DIirLu8zFHj
	 Asgn9oi4r0tHOlzuAvPv7qZXVugKWVkgrEAVKLY/oqRBlQ3+jkkS9Y/Sijk4/9RmE2
	 z1ea3j+eJ40Kw==
Content-Type: multipart/mixed; boundary="===============7689198830902427320=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <795383396857c7b581c6ee1c82178e915c6eca4fd9b346179ece0077b93f68a4@mail.kernel.org>
In-Reply-To: <20260308134614.29711-5-pilgrimtao@gmail.com>
References: <20260308134614.29711-5-pilgrimtao@gmail.com>
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  8 Mar 2026 14:25:06 +0000 (UTC)

--===============7689198830902427320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -86,6 +86,22 @@ #define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
>  #define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
>
> +/* Description
> + *	Insert 'new' after 'prev' in the BPF linked list with head 'head'.

[ ... ]

> +extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_list_node *new,
> +			     struct bpf_list_node *prev, void *meta, __u64 off) __ksym;
> +
> +/* Convenience macro to wrap over bpf_list_add_impl */
> +#define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, prev, NULL, 0)

This adds the extern declaration for bpf_list_add_impl, but the test
also calls bpf_list_del(), bpf_list_empty(), bpf_list_is_first(),
bpf_list_is_last(), and bpf_list_front(). Are the extern __ksym
declarations for those five kfuncs missing from this header?

The v6 of this series added all the declarations here (39 lines), but
v7 reduced it to just bpf_list_add_impl. The btf_dump code in libbpf
(btf_dump.c) treats BTF_KIND_FUNC as unsupported data and does not emit
function prototypes into vmlinux.h:

tools/lib/bpf/btf_dump.c:btf_dump_emit_type_decl_via_under() {
    ...
    case BTF_KIND_FUNC:
    case BTF_KIND_FUNC_PROTO:
        err = btf_dump_unsupported_data(d, t, id);
    ...
}

Without declarations, the BPF program will not compile. The existing
kfuncs in this file (bpf_list_push_front_impl, bpf_list_pop_front,
bpf_list_pop_back, etc.) all have explicit extern __ksym declarations
here. Would something like the following be needed?

    extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
                                              struct bpf_list_node *node) __ksym;
    extern bool bpf_list_is_first(struct bpf_list_head *head,
                                  struct bpf_list_node *node) __ksym;
    extern bool bpf_list_is_last(struct bpf_list_head *head,
                                 struct bpf_list_node *node) __ksym;
    extern bool bpf_list_empty(struct bpf_list_head *head) __ksym;
    extern struct bpf_list_node *bpf_list_front(struct bpf_list_head *head) __ksym;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22822524869
--===============7689198830902427320==--
