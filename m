Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9E369D47
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507791; cv=none; b=KHQTNiQfwIktykUUujISX1vVmIzZxDo5+o0/LCRkOzxh5nPuqCA9Eq/shpysqX7NBac1WkCU18EY/ysmLMmB93lLXb9iHiP+ubwwNItY3F4bUDCBR3vDuI0304q6/RJlQyafiYl26NJ2CEboK+Iz4LENG6ygP/REa/KK+A1XQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507791; c=relaxed/simple;
	bh=XpswYa85qiuiMbT1XnFvBWzd2qUtbha6q7zYMDprpKU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eYgxO2inmwRR5gEE9ekkoBF/fpJYyyDPMtUxQSV6TwlTpPPYlB8Q35UloRtUy0gAJAm1rsiwNY1PS1T/WCnIlGus9N3LmVmE7ql7KOPjOIgOdSSZIyH3rvJq3wTZJbNyCUOvQFZyZrqMn1mwb/n+tcXatGnhTSLD3o2fhRuZ6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0kzt256; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0kzt256"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838141F00A3D;
	Fri,  4 Sep 2026 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507787;
	bh=+R0YLqemQsHVWGS+X+hZOp4MAE2YFy+3l4P0+xwCPjY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U0kzt2562hlp8ha8/XafYBqL9dM+UlBnn5imccxtObHaayvzLguUWjBZQ7aSlsW5p
	 QCk2n1+bV5aUAXTOmxtWrp+JpivFO554eP/Mm1zp4/PVwkKX/GTkj2gAGyh0JPtaSi
	 17Kd0dt+ATRqJiC3t7IP+B0NTW3L/ELwcvDb7yrTaGsDMAetsm7ihYVDVIh499EAHB
	 0FHSKMaFT0qL12ciE9qytK2afFGoNF4/MuS3YgxPh7MEuE8Qm6Vqxyf52WA/5QCscw
	 9pp7zf8fdDQRKPdtio+ZXOUpsVBYy9e4n5Rpcoa88JqcMAOEQG9bhCgzgH6Lu0YuFe
	 vsiwClq6v2g0g==
Content-Type: multipart/mixed; boundary="===============8794906173795559932=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d3db265f9827e399b4d8857e61c241ca4081ce5d5bfdb9a512104bc9943da6f@mail.kernel.org>
In-Reply-To: <20260904063650.3877826-7-memxor@gmail.com>
References: <20260904063650.3877826-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 6/8] selftests/bpf: Reject graph kptr use after RCU unlock
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 07:43:06 +0000 (UTC)

--===============8794906173795559932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> index 31d4081c3a9fd..cdb255addbc30 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 7d2f8897e5ad1..5abd8387d26f3 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -28,6 +28,15 @@ struct map_value_refcount_only {
>  	struct node_refcount_only __kptr *node;
>  };
>
> +struct rcu_graph_node {
> +	struct bpf_rb_node node;
> +	long data;
> +};
> +
> +struct map_value_rcu_graph {
> +	struct rcu_graph_node __kptr *node;
> +};
> +
>  extern void bpf_rcu_read_lock(void) __ksym;
>  extern void bpf_rcu_read_unlock(void) __ksym;
>
> @@ -36,6 +45,8 @@ private(A) struct bpf_spin_lock glock;
>  private(A) struct bpf_rb_root groot __contains(node_acquire, node);
>  private(B) struct bpf_spin_lock lock;
>  private(B) struct bpf_list_head head __contains(node_refcounted, list);
> +private(C) struct bpf_spin_lock graph_lock;
> +private(C) struct bpf_rb_root graph_root __contains(rcu_graph_node, node);

Does struct rcu_graph_node have a forcing construct to ensure Clang emits
a complete BTF_KIND_STRUCT rather than just a forward declaration?

The struct is referenced only through pointer types in this file:

  struct rcu_graph_node __kptr *node;         (map value member)
  struct rcu_graph_node *node;                (pointer locals)
  container_of(rb_node, struct rcu_graph_node, node)

There is no bpf_obj_new(typeof(*n)), no sizeof(), and no by-value use.

The __contains() tag at the private(C) graph_root declaration requires
resolving rcu_graph_node by name as a struct. The kernel resolves this
strictly by name and kind in btf_find_graph_root():

    id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);

If Clang emits only a BTF_KIND_FWD for rcu_graph_node, this returns
-ENOENT, btf_parse_fields() fails for the .data.C internal ARRAY map, and
libbpf's bpf_object__create_maps() fails. That takes down the whole
refcounted_kptr_fail object, so every test in the file reports a failure
with a map-creation error rather than the asserted verifier message.

The immediately preceding commit in this series (1cf6db4cf60b4,
"selftests/bpf: Test borrowed refcount acquisition nullability") had to
add an explicit workaround in this same file for an identical shape:

    /* Force Clang to emit complete BTF for struct node_refcount_only. */
    tmp = bpf_obj_new(typeof(*tmp));
    if (!tmp)
        return 3;
    bpf_obj_drop(tmp);

rcu_graph_node has no equivalent construct. Surveying every __contains()
target in tools/testing/selftests/bpf/progs (node_acquire, node_refcounted,
node_data, skb_node, fq_flow_node, tree_node, tree_node_ref, foo, bar),
every one is instantiated with bpf_obj_new(typeof(*x)) somewhere in the
same object. rcu_graph_node is the first __contains() target in the tree
that never is, so it is the first to depend on pointer-only references
producing a complete struct.

Should this add a forcing construct for rcu_graph_node in the same style
as the sibling test, either a bpf_obj_new(typeof(*node))/bpf_obj_drop()
pair or a statement in the changelog that the emitted BTF was verified to
contain a full STRUCT rather than a FWD for rcu_graph_node?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33846551561
--===============8794906173795559932==--
