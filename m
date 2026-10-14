Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBF3A254A
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999069; cv=none; b=USuKSUiKCHKXKCugtMpbshSYhw0uf8Y0LNk7iGF2NQnh7Gf6G/O8edpake0ra38tTzhM6uuJbgVy47fY8Ay8xhvV86lfpnZAwHrJV2ft+J+Ix9mk4oRVbyVbbvIvYi/vJhMu1nfAIXbx3LgxkwsQCzD7GcOhIkMRn6i4PXzfvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999069; c=relaxed/simple;
	bh=5gH41Eld6XDJSNRPPJ47rSFC5gY4AbROBdKPmpEQegY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJamrEkjF5FgIpydr5ES6iTyUcoCjo+PyxmT/rYFuOROyFRxA6OqzGpk49bqrixHQDubycbF8mXjW9nrdkA/0Ao+B4375y3/3VYGIS0anMj2sxLAal3vZSPqZ0AHtR7rQlWcwULelweEX+fuC1CE8XOvIWU7XgQAmE7oZ7DFFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiGQsps/; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiGQsps/"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67489c8202cso760142d50.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999066; x=1792603866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7mD7i3rFzvjW84wt5tuC9mVD16eLoOhWlZom11I0I0=;
        b=GiGQsps/IUNZZ17Evvgk7hYaNZ+kOSYF7uTKeJotJridASKpnaMDIKR+2gykKf2z+n
         5pLyjF5wQEHmUk4Ss3OLxoOKeW2G/X1yh9C5ol/C+AJdEHMe17mRbSFxWe0tc2zyNnsd
         VLXuXy3BGrMgi3kEnYVrCmYujhogogbwToDm+QK0Z93FXeErpB/zzc9ZEXdlp0FxFD7Z
         mtP8xc0IWovp1dI7qgXDQw5VZqLvk9ye0sBht5oO4LuMoC6S1WGrOAcp7xYyfxR2Uy6H
         ziBbz/5/omja8qWuihR/YajXiitcaggTUuIVdzVdEtPWUv/nvmL19MgxcjoI5Fex/ZYw
         /W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999066; x=1792603866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7mD7i3rFzvjW84wt5tuC9mVD16eLoOhWlZom11I0I0=;
        b=OzNrTsvxVDipG/MgWIz9yJ8adcKFZb66osLNidlteACHqBOVd4ZhPWM7YwWgUPe/Jl
         hMPPZgw4onXaXEszmtXEtaJ8JDIi7OHCChK1OIW5KC59hKQPGZxCi4iA/FYvLkkaBDjx
         KurwdKf2COpFJ0sLJmtipd9+UmQwWX1ULA6/r6kRSMynuZgM8zGIR7jn3txp0T+X4ODV
         r8vomxZ3bK54422v5O3Bkg2JFOIEZYGJsuy5TG4yETooA0S8I3m8VzVIFHYv4Aw+Qd6W
         kJ2S2tCHplvgv4m4maM8aIkYdqSvNxu6YLPzNrj8Q4+szVSejfGDDkzGNBEWUeqzuTYh
         cOxQ==
X-Gm-Message-State: AFq9FYLr6iClZbBgiUf9ijlCMTzHlPpWk293TjTjTVFWG6TMSIhcosaL
	H+EybbQ37HHupcNNSJyj1+55k2H2KWD21eM1sKoJnAQDQQ8S7cCqBZzR
X-Gm-Gg: AYBFou3juaHvXVgUbJYQvfc3yWMNZnFqCc8m+EfiwIkyoYGqPqbwx44bD1SP2JK/grE
	m3gKAeJ/KymMqYaWJpGzEVXt5v4oux0L/YX8jMsA2mUx8eCF9hG4QVhOyMzaMm7+HVlvWqsXaaZ
	Spo0TBHkq4km59A0hfu/eY66jfLhiUkh1MAciVY9ick8ThAvmeLbzlBQeSuiRgtATLHygxGQjqd
	SRuSHOJlDvKGoQOPZM7KPVKpyRJEu1MTHO10/Oyj+1SyG0UmQJZ0PDQKpjzK8gS8cVyjQO46Y9n
	dmyfbWTYSCZ5cA3Id0sxRmRthoiR/Mc7sTuoggOu5fTwDo6JITd9S4zfdz2gvkKRjNHHWDJpNBW
	ki7vXkVdRGSpIX5IzVuTxF4jKaixkFOjebWyJaJG1a0rFa8DWZK6FO3FOwr5WT7A5Cgaa+bXZrB
	HZNjPordkvbJWkdJwJ6jmq8iKbS3GFvDcPLXsiJyH5WYyacMMXdcNB3qM4JYr1ZV1Alygkx/5J
X-Received: by 2002:a05:690e:bc9:b0:679:9063:c4d4 with SMTP id 956f58d0204a3-6799063cfc0mr875355d50.87.1791999065270;
        Wed, 14 Oct 2026 10:31:05 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a66262sm1277803d50.11.2026.10.14.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:04 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 1/4] bpf: Carry MEM_RCU for trusted fields with MEM_RCU parents
Date: Wed, 14 Oct 2026 13:30:36 -0400
Message-ID: <20261014173039.3666415-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014173039.3666415-1-utilityemal77@gmail.com>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute MEM_RCU instead of PTR_TRUSTED for fields declared as trusted
when the parent pointer is MEM_RCU.

Today, walking a field in the __safe_trusted or __safe_trusted_or_null
set invariably yields PTR_TRUSTED if its parent is trusted. If the
parent is instead RCU protected, the resulting pointer survives
bpf_rcu_read_unlock() as fully trusted: it can be dereferenced without
PROBE_MEM and passed to kfuncs expecting trusted arguments after the
parent's RCU grace period, e.g. mm->exe_file (MEM_RCU) followed by
file->f_inode escapes the RCU CS as a trusted inode. Limit the child
field's lifetime to that of the parent.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..20ca8591a0fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6684,9 +6684,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
 		 */
 		if (type_is_trusted(env, reg, field_name, btf_id)) {
-			flag |= PTR_TRUSTED;
+			flag |= is_rcu_reg(reg) ? MEM_RCU : PTR_TRUSTED;
 		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
-			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
+			flag |= (is_rcu_reg(reg) ? MEM_RCU : PTR_TRUSTED) | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
 				/* ignore __rcu tag and mark it MEM_RCU */
-- 
2.55.0

