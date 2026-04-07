Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE838239F
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592168; cv=none; b=ZQzHNxNy6eLDq6PsWkhwYahwj7KdzwmPHLoQzSWygicWFYOAhj/pk1PGyJ9CXZOLd6W3n0c2sQjiyn4aTq02q9WHPR8MgofwQf5AP9/kONcfMByxWJzwcXsSlbnajslwNAnM1e0Td1hPxEfdOIHyAwrO/aRi3pF2qrPxDgwZA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592168; c=relaxed/simple;
	bh=YF5J4wceyOoLcHwxWVLkNkzbdQNVU+WfWpCxranP3Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR00E54SU8vkaP2wgCFJtqVbaXz9yYdTBWBY7jXgbq3FJ6/I5ewqaj732U7nAhrRor7EbSY0F+PfRg24m1BMOfSbACeBgpr/tlyCx9JHuprgDDGfAcTr21Gx6mVAlJZhE9V05VrTEyGz6FlQM+BgsvzlNv1tmCJ4belmL/60rcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHT2h50Q; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHT2h50Q"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501725d888so4371545d50.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592166; x=1776196966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gosc7vTE+s0I2lYg7cK7taBHrkIOJO6I43/Qe9FE/Uo=;
        b=jHT2h50QZ71zW1VlkSDxFHhByD1ZPvSaYi0hntnpyt405FuRXUnYjI7ZaCMrbqyqY7
         9H0AxP0A6qYAxNYEVui4b3Cv5kYvs4Wn06JvMdoRMcfm+RfGuvAPwjrZSoqzIvdFqrSg
         AohFzCQ4Mb+W8jXaDY36cdm34szgvGRm0jjMQwPfnXkdMPQtHpNrxtmx22UBB7zHe7wn
         b6mh4rNWwLIaHiK3etEhpeoZVIfCQ96is9CBDRCtOkyCpMFJdf56d0VBH7VW1KcYC+7I
         FgLbXEgnuHiZvNkA3y3KRc3Z4VU8tu3xKJObDgxw+AdtMqMv/CSC1POmQ8LYDoY8f0Ss
         4cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592166; x=1776196966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gosc7vTE+s0I2lYg7cK7taBHrkIOJO6I43/Qe9FE/Uo=;
        b=dioW6oDvuvksHKafXV5t3MZx6L0d4VZxx9NpKHtDDFy52HtDzAbzSTCijjj3GfYdK0
         6GKaUD1zqOIp9KOCQ9vK44E/ehuczPkbo/l15IRoc5JXE1+aoQBJziztwgXLa3Od7DyC
         uOodNosIGGg89OUWio18a7OzSRqiZIsqm5b3wP/gqWtbb5q3s6lK/L49O4I8lols8k5t
         YwqZ7ecEhDwVh8W0WeBAlDVa+U8WzM9klNn8hREri74xIMzszaC94KAG/hsfJFr/q5xn
         zo56408dJ4Zsj4G2AVjVrSy0xHfKFwxabuDDt+8TfyQIj/rybKnTBOSbb2kgY7yWOPW5
         hT0g==
X-Forwarded-Encrypted: i=1; AJvYcCVYLB2AUd4rBM1FTdAkVncTPP01mwdFbBhOFyzmoKHPeQBug9UjvqB0u4tG1CvAhve5JE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1C4C1NROo6fnZ058kWA6vbwhnWlHyj4WLHSxn5CRybLRCmIQt
	0Sc4rPYsVYlyg36HwmjYdL8yZZp/Ujj54HKGBn1vt7jkumYDs7tUy9gm
X-Gm-Gg: AeBDieumos66M4mT/R9nG5MOL1JLCN/uPJfdYCneUrFYuc8+NuDknAmXzE5Q4fNl7yG
	Yms5WtoZ0QYeZWtyohNCRR4lOml95IlW5Tn7/L4kpLcRn9tVIThTkCobJKa2GTqXnmUCMeF2VC9
	jypF28JB46lKEpP3+cxKsXQyyPTEvtKb7jLTWnO/CLwjwYdWr2yfQ+UtpLiBmx/XgjiRyShAr8N
	0ePuNO5/8tfl4ZOQBT0rcgXOSelh+E7kAESpOWd/WOILIa8vQhAKKWE2u6XdBKv+QAebbEFZKoO
	AnYOlszx+8m9a8/6PmfMPzBG5MgzU5yVNSZTthnAI7axgqXw4mAkI1YQQYuWZa6zPl9+c2U0jOh
	FaIwzQpnOKu+SCfJkJ6dpWAWcMEk7cSQO9rDfh3yGjER7UqWvihtdgWHhH/xM7Cln/6yHkiZu1h
	/ArKTBG3NxjQmgWJNgpt9bpN4hSHiKHi7DANum9qFu9Rt2lptqL5mmf04BJy+3i+DhzHSjhOZXj
	0DCrLHlQHg=
X-Received: by 2002:a05:690e:130c:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-65048814920mr17609725d50.47.1775592166553;
        Tue, 07 Apr 2026 13:02:46 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 16/20] landlock: Bump ABI version
Date: Tue,  7 Apr 2026 16:01:38 -0400
Message-ID: <20260407200157.3874806-17-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump the ABI version in the kernel for the new
RESTRICT_SELF_NO_NEW_PRIVS flag.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c                 | 7 ++++++-
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 66e56ae275c6..53bd77e55855 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -301,7 +301,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 9
+#define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +444,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
 		ruleset_attr.handled_access_fs &=
 			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
+	case 9:
+		/* Removes LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS for ABI < 10 */
+		supported_restrict_flags &=
+			~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6723806723d5..790ac046542f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -130,7 +130,7 @@ static void build_check_abi(void)
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 9;
+const int landlock_abi_version = 10;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index a4c38541de70..51c72064c190 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.53.0

