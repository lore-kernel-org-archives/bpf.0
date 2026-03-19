Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282A36C0D1
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934779; cv=none; b=oMaFrWolrJVfCQcgcs/Mv7HGzJ3+yzY5TD70yVL8B3qLWgmtfug6qmOH6fEXhH8aB9UYB2OEUFTVxoXqqZMDTzxsy4A+15xwFgMKwRJlfdLdXnkF7PWEZDXtMgWAJTyZVk8mGP4XSs4wfWKIueWk0kLgVY9kw0d9xAKLxFOxsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934779; c=relaxed/simple;
	bh=x//o4bWkdTa7UjZoqWBDqdBqMxSW98X7OQ5Mn059qxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dGnYNlkwYWd2FhZStktcB1By7mM92w6sUwKPyAKmSWjm0XNsr2iLBg0vQ104jNPGxmDoKvUOe2lIB5KQ4NJf4w2Q8pRkg7ojWX3aFNRr3M9u6rv29nz1RAy6ASWZzP38QSep65iqfKJYlpII2dhJp9FEF7nzJavQ7Ew1/rbdskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QbBSLqt/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QbBSLqt/"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89c5446f3caso13251076d6.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773934776; x=1774539576; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f+nxQqpbmkQKG1AStGiZRyAzlhJyR4x4hzFywy9Ago=;
        b=QbBSLqt/a46IQeKhCnmfhXuvfzQ71UUU/ir9ucua7JBrMQ5AJ58dWuXrKFc6CmAaB4
         uSq7kxkbMpcxAzdSHs45yyv9FxsInnIoURGn4uwWRqS725tUzbkxyb693cPtcAL+hP2u
         UqQMEP1edtW8/r9UnTAtQjnxIAX2ML7vvA2pYyEoZ+sy1extujt04qgcoZjniIU/wQRm
         PIXC2rNRmQCQlIsb08ZMmrbBBd06LqmClJHOX+cuZg7Mt1Vv0SGrkFfaYNCD9LLhhAHG
         1YST7blvwdFGXt2BHxWiEoU33Zf3MInEDzSJJzy75SCHckZjnRL5lQP078gofnmmsHsC
         4C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773934776; x=1774539576;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9f+nxQqpbmkQKG1AStGiZRyAzlhJyR4x4hzFywy9Ago=;
        b=p2jytlt+MnUlsT/UlJ+pHk51gN3LgEa/Z3DOQvVuIZrehk1UjJznw5X0V8olLS+oTL
         cw2FzRIU9+S40HILjXAlkB4DyQ6mNp1LiScwaoXmpLFtlQmFTl6Mh7J7IzkyjdaiKW+9
         WiaKoUFteX5WlGib0Lg0xBrK6HbekL7QzFGI0du03OJiqxrieGvNJ47k7t4bvUyDVevk
         xWkKljVsjYYZ62ydOTj1yzGqc6zPtgWF9ttV0+oAYpUUEHfN4gFwFZ6qOSq31sMADOY+
         xt8Due8qXeya6Q0A/BH+nbT4aJJXl/aPpPst1umZUFhKevcblWofmH+0/KzfUEO1FNkF
         7mFw==
X-Gm-Message-State: AOJu0Yyeqazxbg/zky38QE7Q8BTlWoCVuENrVogKdaG4psWea2hGK49J
	VxGZWB/9vmdqAJdEZJWVdonobz5MlwNhT4l2ANtFiQ3R4P8sDpvEXJVXgs3Q/Drl31I=
X-Gm-Gg: ATEYQzyEzgZwdHQq+2OxZriAkfhKW10gBmpxb6w/R2mIwam1YNNqobQwg03Ia52bfsg
	v+FezcbBzq1Q2pG5/SmqYVt/LdFAlymDbad0V7PIyhkWmWKYrWE+wkkuMAMoRKpzVEZVBerlVyE
	mL3ajw3kUEsW3grWhd90YV1UnZxEWMX357C6BAFWxfPQADZAZD/JtX7L+pVRS1Z+gaMQ0cIET5G
	VCFLxcVU/G9dzYQOoWz4h5yQbGpTEmSTrD03wQC4UbpvzDCY5vn2SsFuorAf/uB/cFF6jjBjRvN
	9Yzhr25000mGwVfidv4yZTYGggm5Mak5fUGLFagO4yraQLIaaJku0ZOctDqNhMDdwm2bRfICWBQ
	R2fGDTNf3qF4I2jzT08Qubnqde5Kzf0lczl2khZs7rtszLNwypVJVgtISsi9XeU9CUZp2uKNXBX
	dhhUZo0RM0yI7VNO/VocVMYcI=
X-Received: by 2002:a05:6214:3003:b0:89c:6252:4a4a with SMTP id 6a1803df08f44-89c6b5a797emr112213066d6.49.1773934775593;
        Thu, 19 Mar 2026 08:39:35 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b90d1a8sm63300886d6.18.2026.03.19.08.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 08:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:39:34 -0400
Message-Id: <DH6VE8XMH4H8.ETICJE2QVEA5@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 1/8] bpf: refactor kfunc checks using
 table-driven approach in verifier
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-2-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-2-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
> checks with btf_id_in_kfunc_table() and static kfunc tables for easier
> maintenance.
>
> Prepare for future extensions to the bpf_list API family.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The change is valid, can you see if you can remove some of the
is_bpf_*api_kfunc calls areound line 13000 and replace them with=20
btf_id_in_kfunc_table calls?=20

And can you also do this refactoring for the other kfunc families? That
way we replace all functions that match on the btf_id into a single call
that takes in the array we are scanning for a match.

> ---
>  kernel/bpf/verifier.c | 79 +++++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..64c1f8343dfa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12639,6 +12639,53 @@ BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
> =20
> +static const enum special_kfunc_type bpf_list_api_kfuncs[] =3D {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_pop_front,
> +	KF_bpf_list_pop_back,
> +	KF_bpf_list_front,
> +	KF_bpf_list_back,
> +};
> +
> +/* Kfuncs that take a list node argument (bpf_list_node *). */
Nit: Why add a description on just this and bpf_rbtree_node_api_kfuncs?
I think a small comment on top of each if fine if a bit wordy because
it's easy to spot when scanning for a specific kfunc family.
> +static const enum special_kfunc_type bpf_list_node_api_kfuncs[] =3D {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +};
> +
> +/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
> +static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] =3D {
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] =3D {
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_first,
> +	KF_bpf_rbtree_root,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_res_spin_lock_kfuncs[] =3D {
> +	KF_bpf_res_spin_lock,
> +	KF_bpf_res_spin_unlock,
> +	KF_bpf_res_spin_lock_irqsave,
> +	KF_bpf_res_spin_unlock_irqrestore,
> +};
> +
> +static bool btf_id_in_kfunc_table(u32 btf_id, const enum special_kfunc_t=
ype *kfuncs, int n)
> +{
> +	for (int i =3D 0; i < n; i++)
> +		if (btf_id =3D=3D special_kfunc_list[kfuncs[i]])
> +			return true;
> +	return false;
> +}
> +
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
>  	return func_id =3D=3D special_kfunc_list[KF_bpf_task_work_schedule_sign=
al] ||
> @@ -13038,22 +13085,14 @@ static int check_reg_allocation_locked(struct b=
pf_verifier_env *env, struct bpf_
> =20
>  static bool is_bpf_list_api_kfunc(u32 btf_id)
>  {
> -	return btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_front] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_front] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_back];
> +	return btf_id_in_kfunc_table(btf_id, bpf_list_api_kfuncs,
> +				     ARRAY_SIZE(bpf_list_api_kfuncs));
>  }
> =20
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
>  {
> -	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_root] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_left] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_right];
> +	return btf_id_in_kfunc_table(btf_id, bpf_rbtree_api_kfuncs,
> +				     ARRAY_SIZE(bpf_rbtree_api_kfuncs));
>  }
> =20
>  static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
> @@ -13071,10 +13110,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
> =20
>  static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
>  {
> -	return btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock] ||
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsave] |=
|
> -	       btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_irqresto=
re];
> +	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
> +				     ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
>  }
> =20
>  static bool is_bpf_arena_kfunc(u32 btf_id)
> @@ -13163,14 +13200,12 @@ static bool check_kfunc_is_graph_node_api(struc=
t bpf_verifier_env *env,
> =20
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front=
_impl] ||
> -		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back_im=
pl]);
> +		ret =3D btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_node_api_kfuncs,
> +					    ARRAY_SIZE(bpf_list_node_api_kfuncs));
>  		break;
>  	case BPF_RB_NODE:
> -		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] =
||
> -		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl] =
||
> -		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_left] ||
> -		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_right]);
> +		ret =3D btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_node_api_kfuncs=
,
> +					    ARRAY_SIZE(bpf_rbtree_node_api_kfuncs));
>  		break;
>  	default:
>  		verbose(env, "verifier internal error: unexpected graph node argument =
type %s\n",

